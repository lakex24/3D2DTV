clear; clc;

in_stereo_folder = './StereoImages/origin/';
%out_folder       = './Converted/';
out_folder       = './StereoImages/';

ext = '.jpg';
in_filenames = dir([in_stereo_folder '*' ext]);

for i = 1:length(in_filenames)

    in_filename = in_filenames(i).name;
    in_filepath = [in_stereo_folder in_filename];
    
    in_stereo = imread(in_filepath);
    
    is_LR_swapped = false;
    [in_L in_R]   = splitStereo(in_stereo, is_LR_swapped);

    [out_L out_R] = adjustImageSize(in_L, in_R);

    % Generate L + reduced R
    is_reduced_R = true;
    [out_L out_R] = convertStereoPairs(out_L, out_R, is_reduced_R);
    
%out_R = out_R * 0.4;    
    
    out_stereo    = mergeStereo(out_L, out_R);
    
    % File name without suffix
    fname = in_filename(1:(length(in_filename) - length(ext)));
    
%     out_filepath = [out_folder fname '_adjusted' ext];
%     imwrite(out_stereo, out_filepath);
%     
%     out_filepath = [out_folder fname '_L' ext];
%     imwrite(out_L, out_filepath);
%     
%     out_filepath = [out_folder fname '_R' ext];
%     imwrite(out_R, out_filepath);
%     
%     out_filepath = [out_folder fname '_perfect' ext];
%     imwrite([out_L out_L], out_filepath);
    
%     out_filepath = [out_folder fname '_reducedR' ext];
%     imwrite(out_stereo, out_filepath);

    out_filepath = [out_folder fname '_blackR' ext];
    imwrite(out_stereo, out_filepath);

    % Display
    msg = ['Processed Image ' in_filename];
    disp(msg);
end