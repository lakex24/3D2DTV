clear; clc;

in_stereo_folder = './Videos/';
out_folder       = './Converted/';

in_filenames = dir([in_stereo_folder '*.wmv']);

for i = 1:length(in_filenames)

    in_filename = in_filenames(i).name;
    in_filepath = [in_stereo_folder in_filename];
    
    % Initialize Video Reader Settings
    inputVideo = VideoReader(in_filepath);
    lastFrame  = read(inputVideo, inf);
    numFrames  = inputVideo.NumberOfFrames;

    out_filepath = [out_folder 'out_' in_filename];
    outputVideo = VideoWriter(out_filepath);
    outputVideo.FrameRate = inputVideo.FrameRate;
    open(outputVideo);
    
    for n = 1:numFrames
        in_stereo = read(inputVideo, n);
        
        is_LR_swapped = true;
    [in_L in_R]   = splitStereo(in_stereo, is_LR_swapped);

% Generate L + reduced R
% [out_L out_R] = convertStereoPairs(in_L, in_R, true);
% [out_L out_R] = adjustImageSize(out_L, out_R);

% Generate LN+R
% [out_L out_R] = convertStereoPairs(in_L, in_R, false);
% [out_L out_R] = adjustImageSize(out_L, out_R);
    
% Generate size-adjusted stereo
[out_L out_R] = adjustImageSize(in_L, in_R);


    out_stereo    = mergeStereo(out_L, out_R);
        
        writeVideo(outputVideo, out_stereo);
        
        if (mod(n, 100) == 0)
            fprintf('Processing %d frame..\n', n);
        end
    end

    close(outputVideo);
end