clear
clc
pause(1)
errorCode = zeros(1,0);
% uiVal = 'hello'
% uiVal = int16(-1);
%uiVal = [1 2 3; 1 2 3; 1 2 3];
uiVal = [0 2 3 4];

if ~(isnumeric(uiVal) && isreal(uiVal))
    % it's not numeric, real-valued
    errorCode = [errorCode 1]

% Is numeric, real-valued 
elseif any(~(floor(uiVal) == ceil(uiVal)))
    % If it's not integer
    % i.e. it contains non-integer values.
    errorCode = [errorCode 2]
    if any(uiVal < 1) || any(uiVal > 6)
        errorCode = [errorCode 3]
    end
else
    if any(uiVal < 1) || any(uiVal > 6)
        errorCode = [errorCode 3]
    end
end

if ~ismatrix(uiVal) || ~(size(uiVal, 1) == 1 && size(uiVal, 2) == 4)
    errorCode = [errorCode 4]
end