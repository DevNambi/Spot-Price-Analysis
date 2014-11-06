# Spot-Analysis.py
# execfile('/Users/devnambi/Dropbox/spot-analysis.py')
# iterate_queue()

import boto
import boto.ec2
import csv

# VALUES TO SET:
# input_times
# input_availability_zones - the AZs to gather data for
# out_file_stem - the location to write files out to. 

# get the spot price history for a single time range and AZ, and write it to a file
def get_spot_history_range(conn, starttime, endtime, output_file, avail_zone):
	history = conn.get_spot_price_history(start_time=starttime, end_time=endtime, availability_zone=avail_zone)
	with open(output_file, 'w') as f:
		for history_item in history:
			line_to_write = history_item.region.name.encode('ascii','ignore')+','
			line_to_write += history_item.availability_zone.encode('ascii','ignore')+','
			line_to_write += history_item.timestamp.encode('ascii','ignore')+','
			line_to_write += history_item.instance_type.encode('ascii','ignore')+','
			line_to_write += str(history_item.price)+'\n'
			f.write(line_to_write)

# load the list of AZs and times to look at
def load_queue(time_dict, availability_zones_dict):
	input_times = 'SET_THE_VALUE_HERE'
	input_availability_zones = 'SET_THE_VALUE_HERE'
	# now read times
	with open(input_times, 'r') as csvfile:
		timereader = csv.reader(csvfile, delimiter=',')
		for row in timereader:
			time_dict[row[0]] = row[1] #key is start time, value is end time
			#print row[0]
	#next, read zones and regions
	with open(input_availability_zones, 'r') as csvfile:
		az_reader = csv.reader(csvfile, delimiter=',')
		for row in az_reader:
			availability_zones_dict[row[1]] = row[0] #key is az, value is region
			#print row[1]

# iterate over the queue.
def iterate_queue():
	time_dict = {}
	#instance_list = []
	availability_zones_dict = {}
	out_file_stem = 'SET_THE_VALUE_HERE'
	aws_access_key_id = 'SET_THE_VALUE_HERE'
	aws_secret_access_key = 'SET_THE_VALUE_HERE'
	# load all of the items to process into memory using load_queue()
	load_queue(time_dict, availability_zones_dict)
	# now loop through each and get the data
	date_counts = len(time_dict.keys()) * len(availability_zones_dict.keys())
	date_counter = 0
	for az_row in availability_zones_dict.items():
		# first, connect to that region
		print 'Region:'+az_row[1]
		conn = boto.ec2.connect_to_region(az_row[1], aws_access_key_id=aws_access_key_id, aws_secret_access_key=aws_secret_access_key)
		#for instance_row in instance_list:
		# then go through all instance types, one by one
		for time_row in time_dict.items():
			# then go through 
			date_counter = date_counter + 1
			print 'Now processing '+ str(date_counter) + ' out of '+ str(date_counts) + ' dates'
			try:
				start_time = time_row[0]
				end_time = time_row[1]
				#print 'Start: '+ start_time + ' , End: '+ end_time
				region = az_row[1]
				availability_zone = az_row[0]
				#print 'AZ: '+ availability_zone
				output_file = out_file_stem + availability_zone + '-' + start_time + ".csv"
				print 'Output: '+output_file
				get_spot_history_range(conn, start_time, end_time, output_file, availability_zone)
			except (RuntimeError, ValueError):
				print "Unexpected error:", sys.exc_info()[0]