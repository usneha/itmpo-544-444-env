<?php session_start(); ?>
<html>
<head><title>Home Page</title>
</head>
<body>


<form enctype="multipart/form-data" action="result.php" method="POST">
   
 <input type="hidden" name="MAX_FILE_SIZE" value="3000000" />
    <!-- Name of input element determines name in $_FILES array -->
        Send this file: <input name="userfile" type="file" /><br />
	Enter Email of user: <input type="email" name="useremail"><br />
	Enter Phone of user (1-XXX-XXX-XXXX): <input type="phone" name="phone">


<input type="submit" value="Send File" />
</form>
 

<form enctype="multipart/form-data" action="gallery.php" method="POST">
    
Enter Email to look for user folder in the gallery: <input type="email" name="email">
<input type="submit" value="Load Gallery" />
</form>


</body>
</html>
