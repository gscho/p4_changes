require 'thor'

module P4Changes
  class CLI < Thor
    package_name 'p4_changes'

    desc "files DEPOT_LOCATION", "list all changed files at a depot location"
    def files(depot_location)
      res = `git --version`
      puts res
    end
  end
end
