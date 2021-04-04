" foreground colors
%s/\v\<black\>/$(tput setaf 0)/ge
%s/\v\<red\>/$(tput setaf 1)/ge
%s/\v\<green\>/$(tput setaf 2)/ge
%s/\v\<yellow\>/$(tput setaf 3)/ge
%s/\v\<blue\>/$(tput setaf 4)/ge
%s/\v\<magenta\>/$(tput setaf 5)/ge
%s/\v\<cyan\>/$(tput setaf 6)/ge
%s/\v\<lightgray\>/$(tput setaf 7)/ge
%s/\v\<gray\>/$(tput setaf 8)/ge
%s/\v\<lightred\>/$(tput setaf 9)/ge
%s/\v\<lightgreen\>/$(tput setaf 10)/ge
%s/\v\<lightyellow\>/$(tput setaf 11)/ge
%s/\v\<lightblue\>/$(tput setaf 12)/ge
%s/\v\<lightmagenta\>/$(tput setaf 13)/ge
%s/\v\<lightcyan\>/$(tput setaf 14)/ge
%s/\v\<white\>/$(tput setaf 15)/ge
%s/\v\<(\d{-})\>/$(tput setaf \1)/ge

" Reset foreground color. The default is 7.
%s/\v\<\/black\>/$(tput setaf 7)/ge
%s/\v\<\/red\>/$(tput setaf 7)/ge
%s/\v\<\/green\>/$(tput setaf 7)/ge
%s/\v\<\/yellow\>/$(tput setaf 7)/ge
%s/\v\<\/blue\>/$(tput setaf 7)/ge
%s/\v\<\/magenta\>/$(tput setaf 7)/ge
%s/\v\<\/cyan\>/$(tput setaf 7)/ge
%s/\v\<\/lightgray\>/$(tput setaf 7)/ge
%s/\v\<\/gray\>/$(tput setaf 7)/ge
%s/\v\<\/lightred\>/$(tput setaf 7)/ge
%s/\v\<\/lightgreen\>/$(tput setaf 7)/ge
%s/\v\<\/lightyellow\>/$(tput setaf 7)/ge
%s/\v\<\/lightblue\>/$(tput setaf 7)/ge
%s/\v\<\/lightmagenta\>/$(tput setaf 7)/ge
%s/\v\<\/lightcyan\>/$(tput setaf 7)/ge
%s/\v\<\/white\>/$(tput setaf 7)/ge
%s/\v\<(\/\d{-})\>/$(tput setaf 7)/ge

" background colors
%s/\v\<black-g\>/$(tput setab 0)/ge
%s/\v\<red-g\>/$(tput setab 1)/ge
%s/\v\<green-g\>/$(tput setab 2)/ge
%s/\v\<yellow-g\>/$(tput setab 3)/ge
%s/\v\<blue-g\>/$(tput setab 4)/ge
%s/\v\<magenta-g\>/$(tput setab 5)/ge
%s/\v\<cyan-g\>/$(tput setab 6)/ge
%s/\v\<lightgray-g\>/$(tput setab 7)/ge
%s/\v\<gray-g\>/$(tput setab 8)/ge
%s/\v\<lightred-g\>/$(tput setab 9)/ge
%s/\v\<lightgreen-g\>/$(tput setab 10)/ge
%s/\v\<lightyellow-g\>/$(tput setab 11)/ge
%s/\v\<lightblue-g\>/$(tput setab 12)/ge
%s/\v\<lightmagenta-g\>/$(tput setab 13)/ge
%s/\v\<lightcyan-g\>/$(tput setab 14)/ge
%s/\v\<white-g\>/$(tput setab 15)/ge
%s/\v\<(\d{-})-g\>/$(tput setab \1)/ge

" Reset background color. The default is 7.
%s/\v\<\/black-g\>/$(tput setab 0)/ge
%s/\v\<\/red-g\>/$(tput setab 0)/ge
%s/\v\<\/green-g\>/$(tput setab 0)/ge
%s/\v\<\/yellow-g\>/$(tput setab 0)/ge
%s/\v\<\/blue-g\>/$(tput setab 0)/ge
%s/\v\<\/magenta-g\>/$(tput setab 0)/ge
%s/\v\<\/cyan-g\>/$(tput setab 0)/ge
%s/\v\<\/lightgray-g\>/$(tput setab 0)/ge
%s/\v\<\/gray-g\>/$(tput setab 0)/ge
%s/\v\<\/lightred-g\>/$(tput setab 0)/ge
%s/\v\<\/lightgreen-g\>/$(tput setab 0)/ge
%s/\v\<\/lightyellow-g\>/$(tput setab 0)/ge
%s/\v\<\/lightblue-g\>/$(tput setab 0)/ge
%s/\v\<\/lightmagenta-g\>/$(tput setab 0)/ge
%s/\v\<\/lightcyan-g\>/$(tput setab 0)/ge
%s/\v\<\/white-g\>/$(tput setab 0)/ge
%s/\v\<(\/\d{-})-g\>/$(tput setab 0)/ge


%s/\v\<s\>/$(tput smso)/ge
%s/\v\<\/s\>/$(tput rmso)/ge

%s/\v\<b\>/$(tput bold)/ge
%s/\v\<\/b\>/$(tput sgr0)/ge

