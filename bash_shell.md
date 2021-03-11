# Bash linux with params
```bash
#!/bin/bash
while [ -n "$1" ]; do # while loop starts
  case "$1" in
  -option1)
    option1=$param
    shift
    ;;
  -option2)
    option2=$param
    shift
    ;;
  -*) echo "Option $1 not recognized" ;;
  esac
  shift
done

echo "option1: $option1"
```
## Run 
> . test.sh -option1 value1 -option2 value2
