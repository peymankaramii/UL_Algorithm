clc; clear; close all; format long g
numPoints = 2000;                     % number of points
point = sortrows([1:numPoints; rand(1,numPoints)*numPoints; rand(1,numPoints)*numPoints]', 2);

list_CH = point(1, :);          % start hull list with leftmost point
v = numPoints + 1;                     % sentinel value to end loop
i = 0;
while list_CH(1,1) ~= v
    i = i + 1;
    % Calculate unit step towards each candidate point
    X = zeros(1, numPoints);
    Y = zeros(1, numPoints);
    for j = 1:numPoints
        delta_X = list_CH(i, 2) - point(j, 2);
        delta_Y = list_CH(i, 3) - point(j, 3);
        l = sqrt(delta_X^2 + delta_Y^2);         % distance to candidate
        X(j) = list_CH(i, 2) - delta_X / l;      % X after moving 1 unit towards candidate
        Y(j) = list_CH(i, 3) - delta_Y / l;      % Y after moving 1 unit towards candidate
    end
    e1 = find(point(:,1) == list_CH(i,1));  % index of current hull point
    X(e1) = [];
    Y(e1) = [];

    if i == 1
        % first step: choose candidate with lowest Y after unit step
        mini = find(Y == min(Y)) + 1;
        list_CH = [list_CH; point(mini, :)];
    else
        % subsequent steps: select point maximizing turn angle
        c = (X' - list_CH(end-1, 2)).^2 + (Y' - list_CH(end-1, 3)).^2;
        maxi = find(c == max(c));
        if maxi >= e1
            maxi = maxi + 1;
        end
        list_CH = [list_CH; point(maxi, :)];
    end
    v = list_CH(end, 1);         % update sentinel with latest hull point ID
end

% Plot all points in blue
plot(point(:,2), point(:,3), '.b')
hold on
% Plot convex hull in red
plot(list_CH(:,2), list_CH(:,3), 'r', 'LineWidth', 1)
