#!/usr/bin/awk -f
# Create mini statistics on one column in report format
# One dimensional hash tables

BEGIN {;
	printf ("\n\n%s\n", 
		"Calculate some statistics using 1d hash array");
	printf ("%s\t\%s\t%\t\t%s\t%s\t%s\n", 
        	"Level", "Sum", "Avg", "Min", "Max") 
      }

#RUN THRU
{;
	if (NR > 1) {;
		count[$1] += 1;
		if (level[$1] == "") {
			level[$1] = $2
		} else {
			level[$1] += $2
		};
		if (min[$1] == "") {
			min[$1] = $2
		} else {
			if ($2 < min[$1]) { min[$1] = $2 }
		}
		if (max[$1] == "") {
			max[$1] = $2
		} else {
			if ($2 > max[$1]) { max[$1] = $2 }
		}
	}
}

END {;

	for (x in level)
		{ printf ("%s\t%.1f\t%.2f\t%.2f\t%.2f\n", 
	  	x, level[x], level[x]/count[x], min[x], max[x]) 
        }
	printf ("\n\n")
}
