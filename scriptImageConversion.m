clear; clc;

in_stereo_folder = './StereoImages/';
out_folder       = './Converted/';

in_filenames = dir([in_stereo_folder '*.jpg']);

for i = 1:length(in_filenames)

    in_filename = in_filenames(i).name;
    in_filepath = [in_stereo_folder in_filename];
    
    in_stereo = imread(in_filepath);
    
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
    
    out_filepath = [out_folder 'original_' in_filename];
    imwrite(out_stereo, out_filepath);
    
    msg = ['Processed Image ' in_filename];
    disp(msg);
end