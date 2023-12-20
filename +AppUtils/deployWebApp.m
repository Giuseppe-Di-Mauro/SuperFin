function deployWebApp()
ws = warning('off', 'Compiler:compiler:COM_WARN_STARTUP_FILE_INCLUDED');
appFolder = fullfile(fileparts(mfilename("fullpath")), '..');
oc = onCleanup(@() warning(ws));
mlappPath = fullfile(appFolder, 'RoboticFish_NGC_SLSimApp.mlapp');
compiler.build.webAppArchive(mlappPath, ...
	'AdditionalFiles', fullfile(appFolder, 'assets'), ...
	'SupportPackages', 'none', ...
	'OutputDir', fullfile(appFolder, 'deployedWebApp'));
Simulink.output.info(message("simulinkcompiler:genapp:FilesGeneratedAt", ...
	fullfile(appFolder, 'deployedWebApp')).string);
end
