function mycallback2(src, event)
  thisline = str2num(fgetl(src));%lastone
  assignin('base','DATA2',thisline);

end