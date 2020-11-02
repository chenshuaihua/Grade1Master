function [center, U, obj_fcn,train_error_list] = fcm5(data,datalabel,cluster_n,options)

data_n = size(data,1);
in_n = size(data,2);

% Change the following to set default options
default_options = [2;	% exponent for the partition matrix U
		100;	% max. number of iteration
		1e-5;	% min. amount of improvement
		1];	% info display during iteration 

if nargin == 3,
	options = default_options;
else
	% If "options" is not fully specified, pad it with default values.
	if length(options) < 4,
		tmp = default_options;
		tmp(1:length(options)) = options;
		options = tmp;
	end
	% If some entries of "options" are nan's, replace them with defaults.
	nan_index = find(isnan(options)==1);
	options(nan_index) = default_options(nan_index);
	if options(1) <= 1,
		error('The exponent should be greater than 1!');
	end
end

expo = options(1);		% Exponent for U
max_iter = options(2);		% Max. iteration
min_impro = options(3);		% Min. improvement
display = options(4);		% Display info or not

obj_fcn = zeros(max_iter, 1);	% Array for objective function

U = initfcm(cluster_n, data_n);			% Initial fuzzy partition
% Main loop
train_error_list = zeros(max_iter,1);
for i = 1:max_iter,
	[U, center, obj_fcn(i)] = stepfcm(data, U, cluster_n, expo);
    
    centers_5thcol_round = round(center(:,5));
    centers_changed = [center(:,1:4),centers_5thcol_round];
    
    index1 = find(centers_changed(:,5) == 1 );
    index2 = find(centers_changed(:,5) == 2 );
    index3 = find(centers_changed(:,5) == 3 );
    
    %%%每一次迭代过程，每一个训练样本聚类的类别
    cluster_class = zeros(data_n,1);
    for r = 1:data_n
        if(size(index1,1)==3)
            if (U(index1(1),r) > 0.5)|| (U(index1(2),r) > 0.5) || (U(index1(3),r) > 0.5)
                cluster_class(r) = 1;
            elseif (U(index2,r) > 0.5) 
                cluster_class(r) = 2;
            elseif (U(index3,r) > 0.5) 
                cluster_class(r) = 3;
            end
        elseif (size(index2,1)==3)
            if (U(index1,r) > 0.5) 
                cluster_class(r) = 1;
            elseif (U(index2(1),r) > 0.5) || (U(index2(2),r) > 0.5) || (U(index2(3),r) > 0.5)
                cluster_class(r) = 2;
            elseif (U(index3,r) > 0.5) 
                cluster_class(r) = 3;
            end
        elseif (size(index3,1)==3)
            if (U(index1,r) > 0.5) 
                cluster_class(r) = 1;
            elseif (U(index2,r) > 0.5) 
                cluster_class(r) = 2;
            elseif (U(index3(1),r) > 0.5) || (U(index3(2),r) > 0.5) || (U(index3(3),r) > 0.5)
                cluster_class(r) = 3;
            end
        elseif (size(index2,1)==2) || (size(index3,1)==2)
            if (U(index1,r) > 0.5)
                cluster_class(r) = 1;
            elseif (U(index2(1),r) > 0.5)  || (U(index2(2),r) > 0.5)
                cluster_class(r) = 2;
            else
                cluster_class(r) = 3;
            end
        elseif(size(index1,1)==2) || (size(index3,1)==2)
            if (U(index1(1),r) > 0.5) || (U(index1(2),r) > 0.5)
                cluster_class(r) = 1;
            elseif (U(index2,r) > 0.5)
                cluster_class(r) = 2;
            elseif (U(index3(1),r) > 0.5) || (U(index3(2),r) > 0.5)
                cluster_class(r) = 3;
            end
        elseif(size(index1,1)==2) || (size(index2,1)==2)
            if (U(index1(1),r) > 0.5) || (U(index1(2),r) > 0.5)
                cluster_class(r) = 1;
            elseif (U(index2(1),r) > 0.5) || (U(index2(2),r) > 0.5)
                cluster_class(r) = 2;
            elseif (U(index3,r) > 0.5)
                cluster_class(r) = 3;
            end
        end
    end
    
    train_error = 0;
    for s = 1:data_n
        train_error = ( datalabel(s) - cluster_class(s))^2 + train_error;
    end
    
    train_error_list(i) = train_error/data_n;
     
	if display, 
		fprintf('Iteration count = %d, train_error = %f, obj. fcn = %f\n', i, train_error_list(i),obj_fcn(i));
	end
	% check termination condition
	if i > 1,
		if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro, break; end,
	end
end

iter_n = i;	% Actual number of iterations 
train_error_list(iter_n+1:max_iter) = [];
obj_fcn(iter_n+1:max_iter) = [];

