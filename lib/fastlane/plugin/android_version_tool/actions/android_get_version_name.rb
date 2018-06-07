module Fastlane
  module Actions
    module SharedValues
      ANDROID_VERSION_NAME = :ANDROID_VERSION_NAME
    end

    class AndroidGetVersionNameAction < Action
      def self.run(params)
        version_properties_file_path = Helper::AndroidVersionToolHelper.get_version_properties_file_path(params[:version_properties_file])
        version_major = Helper::AndroidVersionToolHelper.read_key_from_version_properties_file(version_properties_file_path, "VERSION_MAJOR")
        version_minor = Helper::AndroidVersionToolHelper.read_key_from_version_properties_file(version_properties_file_path, "VERSION_MINOR")
        version_path = Helper::AndroidVersionToolHelper.read_key_from_version_properties_file(version_properties_file_path, "VERSION_PATCH")
        version_build = Helper::AndroidVersionToolHelper.read_key_from_version_properties_file(version_properties_file_path, "VERSION_BUILD")

        if version_major == false
          UI.user_error!("Unable to find the versionName in version.properties file at #{version_properties_file_path}.")
        end

        UI.success("👍  Current Android Version MAJOR is: #{version_major}")
        UI.success("👍  Current Android Version MINOR is: #{version_minor}")
        UI.success("👍  Current Android Version PATH is: #{version_path}")
        UI.success("👍  Current Android Version BUILD is: #{version_build}")

        version_name = "#{version_major}.#{version_minor}.#{version_path} (#{version_build})"

        # Store the Version Name in the shared hash
        Actions.lane_context[SharedValues::ANDROID_VERSION_NAME] = version_name
      end

      def self.description
        "Get the Version Name of your Android project"
      end

      def self.details
        "This action will return current Version Name of your Android project."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :version_properties_file,
                                  env_name: "FL_ANDROID_GET_VERSION_NAME_VERSION_PROPERTIES_FILE",
                               description: "(optional) Specify the path to your app version.properties if it isn't in the default location",
                                  optional: true,
                                      type: String,
                             default_value: "version.properties",
                              verify_block: proc do |value|
                                UI.user_error!("Could not find version.properties file") unless File.exist?(value) || Helper.test?
                              end)
        ]
      end

      def self.output
        [
          ['ANDROID_VERSION_NAME', 'The Version Name of your Android project']
        ]
      end

      def self.return_value
        "The Version Name of your Android project"
      end

      def self.authors
        ["Miroslav Čupalka"]
      end

      def self.is_supported?(platform)
        [:android].include?(platform)
      end

      def self.example_code
        [
          'version_name = android_get_version_name # version.properties is in the default location',
          'version_name = android_get_version_name(version_properties_file: "/path/to/version.properties")'
        ]
      end
    end
  end
end
