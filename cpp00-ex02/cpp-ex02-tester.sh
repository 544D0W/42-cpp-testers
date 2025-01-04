#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'


clear


echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                                                               ║"
echo "║  ██╗  ██╗██████╗ ███████╗███╗   ██╗██████╗      ██╗ █████╗  ║"
echo "║  ██║  ██║██╔══██╗██╔════╝████╗  ██║██╔══██╗     ██║██╔══██╗ ║"
echo "║  ███████║██████╔╝█████╗  ██╔██╗ ██║██║  ██║     ██║███████║ ║"
echo "║  ██╔══██║██╔══██╗██╔══╝  ██║╚██╗██║██║  ██║██   ██║██╔══██║ ║"
echo "║  ██║  ██║██████╔╝███████╗██║ ╚████║██████╔╝╚█████╔╝██║  ██║ ║"
echo "║  ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═════╝  ╚════╝ ╚═╝  ╚═╝ ║"
echo "║                                                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "${PURPLE}                   Testing Account Implementation${NC}"
echo -e "${BLUE}                         By: hbendjab${NC}"
echo ""


CHECK="✅"
CROSS="❌"
LOADING="⏳"
ROCKET="🚀"
STAR="⭐"

echo -e "${BLUE}${ROCKET} Starting test...${NC}"


echo -e "${YELLOW}${LOADING} Running your program...${NC}"
#mod this to your program name  
./account_test > test_output.txt



cat test_output.txt | sed 's/\[.*\]/[timestamp]/g' | tr -d '\r' > clean_output.txt

#  if you log is diffirent name you should change the .log  or keep defautl 
cat 19920104_091532.log | sed 's/\[.*\]/[timestamp]/g' | tr -d '\r' > clean_log.txt

echo -e "${YELLOW}${LOADING} Comparing outputs line by line...${NC}"
echo ""


total_lines=0
correct_lines=0

while IFS= read -r line_output && IFS= read -r line_log <&3; do
    ((total_lines++))
    

    clean_output=$(echo "$line_output" | tr -d ' ')
    clean_log=$(echo "$line_log" | tr -d ' ')
    
    if [ "$clean_output" = "$clean_log" ]; then
        ((correct_lines++))
        echo -e "${GREEN}${CHECK} Line $total_lines: Correct${NC}"
        echo "   $line_output"
    else
        echo -e "${RED}${CROSS} Line $total_lines: Mismatch${NC}"
        echo "   Your  : $line_output"
        echo "   Should: $line_log"
    fi
done < clean_output.txt 3< clean_log.txt

echo ""

percentage=$((correct_lines * 100 / total_lines))


bar_size=20
filled_size=$((percentage * bar_size / 100))
empty_size=$((bar_size - filled_size))

progress_bar="["
for ((i=0; i<filled_size; i++)); do
    progress_bar+="="
done
for ((i=0; i<empty_size; i++)); do
    progress_bar+=" "
done
progress_bar+="]"

echo -e "${BLUE}Results:${NC}"
echo -e "Progress: $progress_bar ${percentage}%"
echo -e "Correct lines: ${GREEN}$correct_lines${NC}/${total_lines}"

if [ $correct_lines -eq $total_lines ]; then
    echo -e "\n${GREEN}${STAR} All lines match! Perfect score!${NC}"
else
    echo -e "\n${RED}Some lines don't match. Keep trying!${NC}"
fi


rm test_output.txt clean_output.txt clean_log.txt