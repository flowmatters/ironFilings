source_path = ENV["IRON_FILINGS_SOURCE"]
source_path ||= "C:\\Program Files\\eWater\\Source 3.4.3.540\\"
#source_path = "C:\\src\\eWater\\eapp\\Solutions\\Output"

puts "Using Source from " + source_path
$: << source_path

require 'support'
assemblies = ["TIME",
			"TIME.Tools",
			"ScenarioManagement",
			"RiverSystem",
			"RiverSystem.ApplicationLayer",
			"RiverSystem.ApplicationLayer.Interfaces"]

assemblies.each {|a| require a}

ConfigurationSettingsHackery.new.set_config_file('app.config')

l4n = Log4Net.new
l4n.configure

include System
include System::IO
include TIME::DataTypes
include RiverSystem
include RiverSystem::ApplicationLayer
include RiverSystem::ApplicationLayer::Creation
include RiverSystem::ApplicationLayer::Consumers
include RiverSystem::ModelChoice

PluginRegisterUtility::LoadPlugins()

puts "Creating callback"
@callback = DefaultCallback.new
puts "Creating project handler"
@projectHandler = ProjectHandlerFactory.method(:CreateProjectHandler).of(RiverSystemProject).call(@callback)

def load_project(fn)

	project = nil;
# true, false, false, false, forceDevelopmentUpgrade, pluginAssemblyLookup
# bool performAutoProjectUpgrade, bool backupProject, bool overwriteBackups, bool saveBeforeClose, bool developmentMode
    #new FileNameScenarioProviderCallback( true, false, false, false, forceDevelopmentUpgrade, pluginAssemblyLookup )
    @callback.OutputFileName = fn
    #callBack.OutputFileName = projectFilePath

    puts "About to open"
    @projectHandler.OpenProject( )
    puts "About to load"
	@projectHandler.LoadProject( )

	project = @projectHandler.ProjectMetaStructure.Project

#            if ((callBack.NonLoadedProjectPlugins.Count() > 0) || (callBack.NonLoadedAppPlugins.Count() > 0))
#            {
#                StringBuilder pluginsMissing = new StringBuilder();
#                foreach (var plugin in callBack.NonLoadedProjectPlugins)
#                    pluginsMissing.AppendLine(plugin.Name);
#                foreach (var plugin in callBack.NonLoadedAppPlugins)
#                    pluginsMissing.AppendLine(plugin.Name);\
#
#                Log.Write(this, String.Format("The following plugins are used in the project but are not loaded: {0}", pluginsMissing), LogType.Error);
#            }

    project.SetFullFilename(FileInfo.new(fn).FullName)
	project
end

def save_project(project,fn)
	puts "SAVING"
    @callback.OutputFileName = fn
	@projectHandler.ProjectMetaStructure.Project = project
	@projectHandler.ProjectMetaStructure.OutputFile = ""
	@projectHandler.ProjectMetaStructure.SaveProjectToFile = true
	@projectHandler.SaveProject();
end

