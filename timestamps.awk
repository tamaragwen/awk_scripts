#!/opt/homebrew/bin/gawk -f
# Create mini statistics using multi-dimensional array

BEGIN	{;
		fmt_string = "%-10s\t% 10s\t% 9s\t% 8s\t% 8s\n";
		fmt_string2 = "% 28s\t% 8s\t% 8s\t%8.2f\n";
		printf ("%s\n", "Calculate some statistics based on date, via unix timestamps");
		printf (fmt_string, "Day", "Monster", "Count", "Sum", "Avg")
	}

#RUN THRU
	{	if (NR > 1) {;
			if ( $2 ~ /.*\-.*/ ) {; 
				date = substr($2, 2, 10)
				split($4, junky, ":");
				monster = junky[1];
			} else { ;
				date = strftime("%Y-%m-%d", $2);
				split($3, junky, ":");
				monster = junky[1];
			};
			temp = $NF;
			days[date] += 1;
			monsters[monster] += 1;
			data[date, monster, "sum"] += temp;
			data[date, monster, "count"] += 1;
		}
	}
	
END {;	
	for (day in days) {;
		print day;
		for (monster in monsters) {;
			sum = data[date, monster, "sum"];
			count = data[date, monster, "count"];
			if (count == 0) {;
				avg = "--";
				sum = "--"
			} else {;
				avg = sum/count
			};
			printf (fmt_string2, monster, count, sum, avg)
			
		}
	}
}
