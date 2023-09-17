_id = 0;
sprite = 0;

if image_index % 2 == 0 || image_index == 0 state = 0 else state = 1;

if image_index == 0 || image_index == 1 _id = 0;
if image_index == 2 || image_index == 3 _id = 1;
if image_index == 4 || image_index == 5 _id = 2;

if _id = 0 startframe = 0;
if _id = 1 startframe = 2;
if _id = 2 startframe = 4;

firststate = state;