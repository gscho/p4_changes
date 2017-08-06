require 'thor'
require 'p4_changes/p4'

module P4Changes
  class CLI < Thor
    package_name 'p4_changes'
    desc 'files DEPOT_LOCATION', 'list all changed files at a depot location'
    method_option :from, :default => ''
    method_option :to, :default => '#head'
    def files(depot)
      STDOUT.write "\e[36mGathering changelists from #{depot}\e[0m...\n"
      p4 = P4::new(options.from, options.to, depot)
      changelists = p4.get_changeslists()
      STDOUT.write "Changelists found: \e[36m#{changelists.length}\e[0m\n"
      filenames = p4.get_changed_files(changelists)
      p4.write_file(filenames)
    end
  end
end
