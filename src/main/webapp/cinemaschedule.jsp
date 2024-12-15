<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cinema</title>
    <link rel="stylesheet" type="text/css" href="CSS/style.css">
    <link rel="stylesheet" type="text/css" href="CSS/schedule.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

   <section id="cinemaschedule">
    <div id="clock"></div>
    <div id="date"></div>
    <table id="movie-table">
        <thead>
            <tr>
                <th>Movie </th>
                <th>Showtimes</th>
            </tr>
        </thead>
        <tbody>
            <!-- Table rows will be dynamically populated by JavaScript -->
        </tbody>
    </table>
    <div id="app-popup" class="apppopup hide" >
        <div class="popup-content">
            <span class="close-btn" onclick="window.location.reload();">&times;</span>
            <h2>Get the app on Playstore!</h2>
            <a href="https://play.google.com/store" target="_blank">Get this App Now</a> 
        </div>
    </div>
   </section>

   <section id="privacy-policy" class="popup-form hide">
    <div class="popup-content">
        <span class="close-btn">&times;</span>
        <h2>Privacy Policy</h2>
        <h4>INFORMATION WE COLLECT
            PERSONAL INFORMATION
            Personal Information may be submitted to NSR for the purposes of <br>
            (a) receiving information from us;<br>
            (b) buy movie ticket through Site; and <br>
            (c) other purposes to support Service through Site. 
            </h4>
    </div>
</section>
<jsp:include page="footer.jsp"></jsp:include>

    <script src="JS/schedule.js" defer></script>
</body>
</html>