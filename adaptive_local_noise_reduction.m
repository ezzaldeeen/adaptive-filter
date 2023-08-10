function estimated_image = adaptive_local_noise_reduction(g, sigma_n, window_size)
%REDUCE_NOISE Adabtive Local Noise Reduction
%   ARGUMENTS:
%       g: given target image (noisy image)
%       sgima_n: is the overall noise variance
%       window_size: the size of the sliding window

% unpack the shape of the image
[nrows, ncols] = size(g);
estimated_image = zeros(nrows, ncols);

% calcucate total slides for both directions: cols, and rows
num_col_slides = (ncols - window_size) + 1;
num_row_slides = (nrows - window_size) + 1;

    for start_row_slide = 1:num_row_slides
        for start_col_slide = 1:num_col_slides
            % calculate window sliding
            end_row_slide = window_size+start_row_slide-1;
            end_col_slide = window_size+start_col_slide-1;
    
            % slice local window form the given image
            local_window = g(start_row_slide:end_row_slide, ...
                             start_col_slide:end_col_slide);
    
            % compute local mean & local variance
            local_mean = mean(local_window(:));
            local_variance = var(local_window(:));

            % to ensure that the rate is between [0, 1]
            rate = max(sigma_n, 0) / max(sigma_n, local_variance);

            % 
            estimated_image( ...
                start_row_slide:end_row_slide, ...
                start_col_slide:end_col_slide ...
                ) = local_window - rate * (local_window - local_mean);
        end
    end
end

