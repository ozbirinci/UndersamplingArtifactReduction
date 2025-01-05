function imageInfo = imageInfo(filename)
    % get filename without extension
    [~, name, ~] = fileparts(filename);
    
    % break filename into parts using underscores
    parts = split(name, '_');
    
    % show parts for debugging
    disp(parts);
    
    % check if filename has enough parts
    if numel(parts) < 6
        error('filename format is incorrect. expected at least 6 parts separated by underscores.');
    end
    
    % extract basic image info
    imageInfo.modality = upper(parts{1});     % convert t1/t2 to T1/T2
    imageInfo.protocol = upper(parts{2});     % convert icbm/ai to ICBM/AI
    imageInfo.phantom = parts{3};             % normal or msles2
    imageInfo.thickness = parts{4};           % slice thickness (1mm, 3mm, etc)
    
    % get noise level from pn0 format
    noise_str = parts{5};
    imageInfo.noise = [noise_str(3:end) '%']; % extract number after 'pn'
    
    % get inu from rf0 format
    inu_str = parts{6};
    imageInfo.inu = [inu_str(3:end) '%'];     % extract number after 'rf'
    
    % create summary string for display
    imageInfo.displayStr = sprintf('modality=%s, protocol=%s\nphantom=%s, thickness=%s\nnoise=%s, inu=%s', ...
        imageInfo.modality, imageInfo.protocol, imageInfo.phantom, imageInfo.thickness, ...
        imageInfo.noise, imageInfo.inu);
end