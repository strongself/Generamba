require 'generamba/constants/user_preferences_constants.rb'

module Generamba

  # A class that provides methods for working with user-specific information.
  # Currently it has methods for obtaining and saving username, later it may be improved to something more general.
  class UserPreferences

    def self.obtain_username
      path = obtain_user_preferences_path

      file_contents = open(path).read
      preferences = file_contents.empty? ? {} : YAML.load(file_contents).to_hash

      return preferences[USERNAME_KEY]
    end

    def self.save_username(username)
      path = obtain_user_preferences_path

      file_contents = open(path).read
      preferences = file_contents.empty? ? {} : YAML.load(file_contents).to_hash

      preferences[USERNAME_KEY] = username
      File.open(path, 'w+') { |f| f.write(preferences.to_yaml) }
    end

    private

    def self.obtain_user_preferences_path
      home_path = Pathname.new(ENV['HOME'])
                 .join(GENERAMBA_HOME_DIR)

      path_exists = Dir.exist?(home_path)

      if path_exists == false
        FileUtils.mkdir_p home_path
      end

      preferences_path = home_path.join(USER_PREFERENCES_FILE)
      preferences_exist = File.file?(preferences_path)

      if preferences_exist == false
        File.open(preferences_path, 'w+') { |f| f.write('') }
      end

      return preferences_path
    end
  end
end