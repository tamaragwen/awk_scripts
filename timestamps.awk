#!/opt/homebrew/bin/gawk -f
# Create mini statistics using multi-dimensional array


BEGIN	{;
		fmt_string = "%-10s\t% 10s\t% 8s% 9s\t% 8s\t% 8s\n";
		fmt_string2 = "% 38s\t% 8s\t% 8s\t%8.2f\n";
		printf ("\n\n%s\n", "Calculate some statistics based on date, via unix timestamps");
		printf (fmt_string, "Day", "Monster", "Temp1/2", "Count", "Sum", "Avg")
	}


#RUN THRU
{;
	if (NR > 1) { 
		day = strftime("%Y-%m-%d", $2);
		# day = substr($2, 2, 10)
		split($5, field5, ":");
		monster = field5[1];
		temp1 = $6;
		temp2 = $7;

		days[day] += 1;
		monsters[monster] += 1;
		data[day, monster, "temp1", "sum"] += temp1;
		data[day, monster, "temp1", "count"] += 1;
		data[day, monster, "temp2", "sum"] += temp2;
		data[day, monster, "temp2", "count"] += 1;
	}
	
}

END {;	
	for (day in days) {;
		print day;
		for (monster in monsters) {;
			printf("% 26s\n", monster)
			count1 = data[day, monster, "temp1", "count"];
			sum1 = data[day, monster, "temp1", "sum"];
			count2 = data[day, monster, "temp2", "count"];
			sum2 = data[day, monster, "temp2", "sum"];
			if (count1 == 0) {;
				count1 = "--";
				sum1 = "--";
				avg1 = "--"
			} else { avg1 = sum1 / count1 };
			if (count2 == 0) {;
				count2 = "--";
				sum2 = "--";
				avg2 = "--"
			} else {avg2 = sum2 / count2};
			printf(fmt_string2, "Temp1", count1, sum1, avg1);
			printf(fmt_string2, "Temp2", count2, sum2, avg2)
		}
	}
}
