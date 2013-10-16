require 'System.Configuration, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'
 
class ConfigurationSettingsHackery
  def set_config_file(new_config_file)
    set_config_file_on_current_app_domain(new_config_file)
    refresh_current_client_config_paths
    reset_configuration_manager_to_force_reload
  end
  
  
  private
  
  def non_public_binding
    System::Reflection::BindingFlags.NonPublic
  end
  
  def non_public_static_binding
    non_public_binding | System::Reflection::BindingFlags.Static
  end
  
  def non_public_instance_binding
    non_public_binding | System::Reflection::BindingFlags.Instance
  end
  
  def set_config_file_on_current_app_domain(new_config_file)
    domainSetup = System::AppDomain.CurrentDomain.GetType().
      GetProperty("FusionStore", non_public_instance_binding).
      GetGetMethod(true).Invoke(System::AppDomain.CurrentDomain, nil)
    domainSetup.ConfigurationFile = new_config_file
  end
  
  def refresh_current_client_config_paths
    configSystem = System::Configuration::ConfigurationManager.
      to_clr_type.GetField("s_configSystem", non_public_static_binding).
      GetValue(nil)
    configHost = configSystem.GetType().
      GetField("_configHost", non_public_instance_binding).
      GetValue(configSystem)
    configHost.GetType().Assembly.
      GetType('System.Configuration.ClientConfigPaths').
      GetMethod("RefreshCurrent", non_public_static_binding).
      Invoke(nil, nil)
  end
  
  def reset_configuration_manager_to_force_reload
    initStateType = System::Configuration::ConfigurationManager.
      to_clr_type.GetNestedType("InitState", non_public_binding)
    state = initStateType.GetField("NotStarted").
      GetValue(initStateType)
    System::Configuration::ConfigurationManager.
      to_clr_type.GetField("s_initState", non_public_static_binding).
      SetValue(nil, state)  
  end
end
 
class Log4Net
  def initialize() 
    @log4net = IronRuby.require('log4net')
  end
 
  def configure
    @log4net.GetType("log4net.Config.BasicConfigurator").GetMethod("Configure", System::Array.of(System::Type).new(0)).Invoke(nil, nil)
  end
  
  def logger(log_name) 
    log = @log4net.GetType("log4net.LogManager").GetMethod("GetLogger", System::Array.of(System::Type).new(1) {System::String.to_clr_type}).Invoke(nil, System::Array.of(System::String).new(1) {log_name})
  end
  
  def print_root_log_levels
    log = logger('default')
 
    puts "Is debug enabled: #{log.IsInfoEnabled}"
    puts "Is error enabled: #{log.IsErrorEnabled}"
    puts "Is fatal enabled: #{log.IsFatalEnabled}"
    puts "Is info enabled: #{log.IsInfoEnabled}"
    puts "Is warn enabled: #{log.IsWarnEnabled}" 
  end
end

