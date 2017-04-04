function extractFeature
myFolder = '/Users/mattclifford/Documents/SPS/CourseWork2/characters/trainGIF';

filePattern = fullfile(myFolder, '*.GIF');
jpegFiles = dir(filePattern);
length(jpegFiles)