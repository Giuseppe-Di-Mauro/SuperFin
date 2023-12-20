appFolder = fullfile(fileparts(mfilename("fullpath")), '..');
mlappFile = fullfile(appFolder, 'RoboticFish_NGC_SLSimApp');
run(mlappFile);
