function [index] = RouletteWheelSelection(x)

    index=find(rand() <= cumsum(x) ,1,'first');

end