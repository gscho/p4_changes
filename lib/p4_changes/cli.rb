require 'thor'

module P4Changes
  class CLI < Thor
    package_name 'p4_changes'

    desc 'files DEPOT_LOCATION', 'list all changed files at a depot location'
    method_option :from, :default => ''
    method_option :to, :default => '#head'
    def files(depot_location)
      res = `git --help`.split( /\n/ )
      changelists = []
      res.each do |line|
        changelist = line.split(' ')
        changelists << changelist[1] unless changelist[1].nil?
      end
      files = []
      changelists
      .map { |num| `p4 -Ztag -F "%depotFile%" files @=#{num}`.split( /\n/ ) }
      .flatten
      .each do |path|
        puts path
      end
    end
  end
end
