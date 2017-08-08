module P4Changes
  class P4
    attr_accessor :to, :from
    def initialize(from, to, depot)
      @to = to
      @from = from
      @depot = depot
      self.format
    end

    def format
      if !@from.eql? '' then
        @from = @from.dup.prepend('@') << ','
      end
      if !@to.eql? '#head' then
        @to = @to.dup.prepend('@')
      end
    end

    def get_changelists
      changelists = `p4 changes #{@depot}...#{@from}#{@to}`.split( /\n/ )
      changelists = changelists
      .reduce([]) { |arr,change|
        change = change.split(' ')
        arr << change[1] unless change[1].nil?
      }
      changelists
    end

    def get_changed_files changelist_arr
      num_files = 0
      changelist_arr
      .map { |num|
        result = `p4 -Ztag -F "%depotFile%" files @=#{num}`.split( /\n/ )
        num_files += result.length
        STDOUT.write "\r\e[36m#{num_files}\e[0m changed files"
        result
      }
      .flatten
      .uniq
    end

    def write_files filenames
      d = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      depot = @depot.tr('/', '')
      STDOUT.write "\nWriting unique filenames to \e[36m#{depot}-#{d}.txt\e[0m"
      File.open("#{depot}-#{d}.txt", 'w') {|f| f.puts(filenames)}
    end
  end
end
