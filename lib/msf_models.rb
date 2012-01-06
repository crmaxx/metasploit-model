require "active_record"
require "active_support"
require "active_support/all"

require "msf_models/version"
require "msf_models/module_monkeypatch"
require "msf_models/serialized_prefs"
require "msf_models/base64_serializer"
require "msf_models/db_manager/db_objects"

module MsfModels
  def self.included(base)
    if base == Msf::DBManager
      loadable_models.each{|file| base.module_require(file)}
    else
      loadable_models.each{|file| load file}
    end
  end

  def self.loadable_models
    models_dir = File.expand_path(File.dirname(__FILE__)) + "/msf_models/active_record_models"
    Dir.glob("#{models_dir}/*.rb")
  end
end
