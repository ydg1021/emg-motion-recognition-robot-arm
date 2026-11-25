%% imu bytesavailableFcn 관련 함수
function mycallback(src, event)
  thisline = str2num(fgetl(src));%lastone
  assignin('base','DATA',thisline);
end
% 실시간으로 imu 데이터를 작업공간 DATA 행렬에 표시하는 역할