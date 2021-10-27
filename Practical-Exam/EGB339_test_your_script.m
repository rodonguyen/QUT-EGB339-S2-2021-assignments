clear all
close all


% set your group number here
group_number = 19

% this script expects a submission file called EGB339_prac_exam_group_XX.m in the
% current folder, where XX is a 2 digit group number with leading zero if
% required.
%
% The submission file must obey the call protocol discussed in the lecture
% and documented on Teams.

fname = sprintf('EGB339_21S2_%02d', group_number);

if ~exist(fname, 'file')
    error('solution file %s not found\n', fname)
end
student_func = str2func(fname);

%change this for different input sheets
init_image = imread('init_image1.jpg');
dest_image = imread('init_image3.jpg');

%this will not be made available but used to determine marks
%this example is for TestSheet1 and TestSheet8 for exam sheet 1
true_init_pos = [
    146 159
    94 83
    99 499
    ];
true_dest_pos = [
    254 103
    215 214
    192 467
    ];

%% call student function first off with no arguments to get the desired
% maximum score
marks = student_func();
if marks == 12 || marks == 20
    fprintf('You are going for %d marks\n', marks)
else
    error('the number of marks you are going for must be either 12 or 20')
end

%% run it

for i = 1:1
       
    sim = coppeliaRobot('Dobot');
    sim.startSim(1); 
    
    %use this to change the exam practice sheet (1 or 2)
    sim.showExamSheet(1)
    sim.setTargetGoalPositions(true_init_pos, true_dest_pos)
        
    %if current_run_flags.cylinders_present
    sim.setCylinderPosition(true_init_pos)
        
    if marks == 20
        % pass in images
        retval = student_func(sim, init_image, dest_image);
        
    else
        % pass in xy coordinates
        sim.setTargetGoalPositions(true_init_pos, true_dest_pos)
        
        student_func(sim, true_init_pos, true_dest_pos);
    end
    
    
    %% OK, all done, let's see how it went
    
    % where are the cylinders?
    actual_cyl_pos = sim.getCylinderPositions();
    %actual_tool_pos = sim.tool_goal_dist;
    
    % what were the estimates of start and dest cylinder positions
    if marks == 20
        ret_init_pos = retval{1};
        ret_dest_pos = retval{2};
    else
        ret_init_pos = [];
        ret_dest_pos = [];
    end
    
    run_mark(i) = calculate_mark(ret_init_pos, ret_dest_pos, true_init_pos, true_dest_pos, actual_cyl_pos, marks)
    fprintf('\n')
    
    sim.clearToolGoalDistances();
    clear sim;
end

function total_mark = calculate_mark(ret_init_pos, ret_dest_pos, true_init_pos, true_dest_pos, cyl_pos, marks)

   %evalaute performance of run
        
    vis_pos_mark = 0;
    tool_marks = 0;
    cyl_pos_mark = 0;
    

    if marks == 20
        % vision score, out of 5
        vision_init_error = rownorm(ret_init_pos - true_init_pos);
        vision_dest_error = rownorm(ret_dest_pos - true_dest_pos);
        
        for j = 1:3
            if vision_init_error(j) <= 5
                vis_pos_mark = vis_pos_mark + 5/6;
            elseif vision_init_error(j) <= 10
                vis_pos_mark = vis_pos_mark + 4/6;
            elseif vision_init_error(j) <= 10
                vis_pos_mark = vis_pos_mark + 2/6;
            end
            
            if vision_dest_error(j) <= 5
                vis_pos_mark = vis_pos_mark + 5/6;
            elseif vision_dest_error(j) <= 10
                vis_pos_mark = vis_pos_mark + 4/6;
            elseif vision_dest_error(j) <= 10
                vis_pos_mark = vis_pos_mark + 2/6;
            end
        end
        
        fprintf('vision to find cylinder xy %.1f\n', vis_pos_mark)
            
        %distance error
        cyl_pos_distance = rownorm(cyl_pos - true_dest_pos);
        cyl_init_pos_distance = rownorm(cyl_pos - true_init_pos);
        
        %accuracy of cylinder final position
        for j = 1:3
            if cyl_pos_distance(j) <= 10
                cyl_pos_mark = cyl_pos_mark + 5;
            elseif cyl_pos_distance(j) <= 20
                cyl_pos_mark = cyl_pos_mark + 3;
            elseif cyl_pos_distance(j) <= 30
                cyl_pos_mark = cyl_pos_mark + 2;
            elseif cyl_pos_distance(j) <= 50
                cyl_pos_mark = cyl_pos_mark + 1;
            end
        end
    else

        %distance error
        cyl_pos_distance = rownorm(cyl_pos - true_dest_pos);
        cyl_init_pos_distance = rownorm(cyl_pos - true_init_pos);
        
        %accuracy of cylinder final position
        for j = 1:3
            if cyl_pos_distance(j) <= 10
                cyl_pos_mark = cyl_pos_mark + 4;
            elseif cyl_pos_distance(j) <= 20
                cyl_pos_mark = cyl_pos_mark + 3;
            elseif cyl_pos_distance(j) <= 30
                cyl_pos_mark = cyl_pos_mark + 2;
            elseif cyl_pos_distance(j) <= 50
                cyl_pos_mark = cyl_pos_mark + 1;
            end
        end
    end

    total_mark = vis_pos_mark + cyl_pos_mark;

    fprintf('moving the cylinder cylinder xy %.1f\n', cyl_pos_mark)
    fprintf('TOTAL: %.1f\n', total_mark)
end

function n = rownorm(a) 
    a = a';
	n = sqrt(sum(a.^2));
end