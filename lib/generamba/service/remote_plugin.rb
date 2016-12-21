module Generamba
  module Service
    # == Generamba \Service \RemotePlugin
    #
    # Provides an object for synchronization and installation remote plugins
    #
    # It allows you to do:
    #
    #   generamba_git = Generamba::Service::RemotePlugin.new(
    #     'git@github.com:rambler-digital-solutions/Generamba.git',
    #     type: :plugin_type,
    #     branch: 'master'
    #   )
    #
    #   generamba_git.sync              # => download or update plugin
    #   generamba_git.loaded_plugin?    # => return true if loaded plugin, else return false
    #   generamba_git.cached_plugin_dir # => return a directory on local disk

    class RemotePlugin
      GENERAMBA_PLUGINS_PATH = "#{Dir.pwd}/.generamba".freeze

      def initialize(repo_link, type: '', branch: :master)
        @link   = repo_link
        @type   = type
        @branch = branch
      end

      def sync
        loaded_plugin? ? update_plugin : download_plugin
      end

      def cached_plugin_dir
        dir_name = URI.parse(link).path[1..-1] unless ssh_url?
        dir_name ||= link.split(':').last.gsub(/\.git$/, '') # regexp: last `.git`

        [GENERAMBA_PLUGINS_PATH, type, dir_name].join('/')
      end

      def loaded_plugin?
        Dir.exist?(cached_plugin_dir)
      end

      private

      def download_plugin
        git_repo = Git.clone(link, cached_plugin_dir)

        git_repo.branch(branch).checkout unless branch.empty?
      end

      def update_plugin
        git_repo = Git.open(cached_plugin_dir)
        git_repo.branch(branch).checkout unless branch.empty?
        git_repo.pull
      end

      def ssh_url?
        URI.parse link
        false
      rescue URI::InvalidURIError
        true
      end

      attr_reader :link, :type, :branch
    end
  end
end
