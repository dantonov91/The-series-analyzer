#!/bin/bash


validate() {
  valid='^[0-9]+$'
  
  if [[ $1 =~ $valid ]] && (( $(echo "$1 > 0" ) )); then
    return 0
  else
    return 1
    fi
}

input_series() {

read -p "Enter a series of positive numbers: " input
series=($input)
for num in "${series[@]}"; do
if [[ ${#series[@]} -lt 3 ]];then
    echo "Invalid input. Please enter at least three positive integers."
input_series
fi

if ! validate "$num"; then

echo "Invalid numbers. Please enter a series of positive numbers."
input_series
fi
done
}

display() {
echo -e "\nDisplay: ${series[@]}\n"

}



sorting() {
sorted_numbers=($(printf '%s ' "${series[@]}" | tr ' ' '\n' | sort -n))
echo -e "\nSorted numbers: ${sorted_numbers[*]}\n"
}

average() {
    local sum=0
    local count=0
    
    for number in "${series[@]}"; do
        sum=$((sum + number))
        count=$((count + 1))
    done
    
    if [[ $count -gt 0 ]]; then
average=$(echo "scale=2; $sum / $count" | bc -l)
        echo " "
        echo "The average is: $average"
        echo " "
    fi
}

max() {
local max=0     
for num in "${series[@]}"; do
    if [[ $num -gt $max ]]; then
        max=$num
    fi
 done
 echo -e "\nThe max number is: $max\n"
}


min() {
local min=${series[0]}
for number in "${series[@]}"; do
if [[ $number -le $min ]]; then
min=$number
fi
done
echo -e "\nThe min number is: $min\n"
}

# Display the sum
display_sum() {
    local sum=0
    for num in "${series[@]}"; do
        ((sum += num))
    done
    echo -e "\nSum: $sum\n"
}

length() { 
 len=${#series[@]}

echo -e "\nLength: $len\n"
}


menu() {
while true; do
   PS3="Select an operation: "
    options=("Input a series" "Display" "Sort" "Max" "Min" "Average" "Length" "Sum" "Exit")

    select menu_answer in "${options[@]}"; do
        case $menu_answer in
            "Input a series")
               input_series
               menu              
                ;;
            "Display")
            display
                ;;
            "Sort")
                sorting
                ;;
            "Max")
                max
                ;;
            "Min")
                min
                ;;
            "Average")
                average
                 ;;
                 "Length")
                length
                ;;
                 "Sum")
                display_sum
                ;;
            "Exit")
                echo "Goodbye!"
                exit 0
                ;;
            *)
                echo "Invalid choice. Please select a valid option."
                ;;
        esac

      
        break  # Exit the inner select loop to display the menu again
    done
done
}

input_series
menu




