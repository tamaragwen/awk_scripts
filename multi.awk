#!/usr/bin/awk -f
# Create mini statistics using multi-dimensional array

BEGIN { printf ("\n\n%s\n", 
		"Calculate some statistics using multi-dimensional array");
	printf ("%-5s\t%-10s\t%-8s\t%-8s\n",
		"Level", "Monster", "Sum", "Min") }

#RUN THRU
{;
	if (NR > 1) { value = $3; level = $1; 
		split ($2, junky, ":"); monster = junky[1];
		levels[level] += 1;
		monsters[monster] += 1;
		
		# When adding a num awk will default to 0
		data[level, monster, "count"] += value;
		data[level, monster, "sum"] += value;

		# Must intialize when comparing numbers
		if (data[level, monster, "min"] == "") {;
			data[level, monster, "min"] = value
		} else {;
			if (value < data[level, monster, "min"]) {;
				data[level, monster, "min"] = value }
		}
	}
}

END {	for (level in levels) {;
		for (monster in monsters) {;
			c = data[level, monster, "count"];
			if (c == "") { c = "--" };
			s = data[level, monster, "sum"];
			if (s == "") { s = "--" };
			m = data[level, monster, "min"];
			if (m == "") {m = "--"};
			printf ("%-5s\t%-10s\t%-8s\t%-8s\n",
				level, monster, s,  m)
		}
	}
}
