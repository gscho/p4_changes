require 'thor'

module P4Changes
  class CLI < Thor
    package_name 'p4_changes'

    desc 'files DEPOT_LOCATION', 'list all changed files at a depot location'
    method_option :from, :default => ''
    method_option :to, :default => '#head'
    def files(depot)
      STDOUT.write "\e[36mGathering changelists from #{depot}\e[0m...\n"
      res = `p4 changes #{depot}...#{options.from}#{options.to}`.split( /\n/ )
      changelists = []
      res.each do |line|
        changelist = line.split(' ')
        changelists << changelist[1] unless changelist[1].nil?
      end
      STDOUT.write "Changelists found: \e[36m#{changelists.length}\e[0m\n"
      num_files = 0
      files = 
      changelists
      .map do |num| 
        result = `p4 -Ztag -F "%depotFile%" files @=#{num}`.split( /\n/ )
        num_files += result.length
        STDOUT.write "\r\e[36m#{num_files}\e[0m changed files"
        result
      end
      .flatten
      .uniq
      d = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      depot = depot.tr('/', '')
      STDOUT.write "\nWriting unique filenames to \e[36m#{depot}-#{d}.txt\e[0m"
      File.open("#{depot}-#{d}.txt", 'w') {|f| f.puts(files)}
    end
  end
end
