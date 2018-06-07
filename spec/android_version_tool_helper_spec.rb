require 'spec_helper'

describe Fastlane::Helper::AndroidVersionToolHelper do
  describe "Androiversiontool Android Helper" do
    it "should return path to version.properties" do
      result = Fastlane::Helper::AndroidVersionToolHelper.get_version_properties_file(nil)
      expect(result).to eq(Fastlane::Helper::AndroidVersionToolHelper::VERSION_PROPERTIES_FILE_TEST)
    end

    it "should return absolute path to version.properties" do
      xcodeproj = Fastlane::Helper::AndroidVersionToolHelper::VERSION_PROPERTIES_FILE_TEST
      result = Fastlane::Helper::AndroidVersionToolHelper.get_version_properties_file_path(xcodeproj)
      expect(result).to eq("/tmp/fastlane/tests/androiversiontool/version.properties")
    end
  end
end
