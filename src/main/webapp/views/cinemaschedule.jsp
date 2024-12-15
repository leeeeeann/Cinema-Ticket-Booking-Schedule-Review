<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cinema Schedule</title>
    <style>
        /* Your CSS styles here */
    </style>
</head>
<body>
    <section id="cinemaschedule">
        <div id="clock"></div>
        <div id="date"></div>
        <table id="movie-table">
            <thead>
                <tr>
                    <th>Movie</th>
                    <th>Showtimes</th>
                </tr>
            </thead>
            <tbody>
                <!-- Table rows will be dynamically populated by JavaScript -->
            </tbody>
        </table>
        <div id="app-popup" class="apppopup hide">
            <div class="popup-content">
                <span class="close-btn" onclick="window.location.reload();">&times;</span>
                <h2>Get the app on Playstore!</h2>
                <a href="https://play.google.com/store" target="_blank">Get this App Now</a> 
            </div>
        </div>
    </section>
    <script>
        function updateClockAndDate() {
            const now = new Date();
            let hours = now.getHours();
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');

            const day = String(now.getDate()).padStart(2, '0');
            const year = now.getFullYear();

            const daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            const monthsOfYear = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

            const dayOfWeek = daysOfWeek[now.getDay()];
            const month = monthsOfYear[now.getMonth()];

            const ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'

            const clock = document.getElementById('clock');
            const date = document.getElementById('date');

            clock.textContent = `${hours}:${minutes}:${seconds} ${ampm}`;
            date.textContent = `${dayOfWeek}, ${day} ${month} ${year}`;
        }

        function addMovieRow(posterUrl, showtimes, title, duration, age) {
            const tableBody = document.querySelector('#movie-table tbody');
            const newRow = document.createElement('tr');

            const posterCell = document.createElement('td');
            const posterImg = document.createElement('img');
            posterImg.src = posterUrl;
            posterImg.alt = 'Movie Poster';
            posterCell.appendChild(posterImg);
            newRow.appendChild(posterCell);

            const showtimesCell = document.createElement('td');
            const showtimesWrapper = document.createElement('div');

            // Add title, duration, and age information above showtimes
            const infoLine = document.createElement('div');
            infoLine.classList.add('movie-info');
            infoLine.textContent = `${title} | ${duration} | ${age}`;
            showtimesCell.appendChild(infoLine);

            // Create buttons for each showtime
            const showtimesArray = showtimes.split(', ');
            showtimesArray.forEach(time => {
                const showtimeBtn = document.createElement('button');
                showtimeBtn.textContent = time;
                showtimeBtn.classList.add('showtime-btn'); // Optional: add a class for styling

                // Parse time and AM/PM
                const [timeStr, period] = time.split(' ');
                const [hours, minutes] = timeStr.split(':').map(num => parseInt(num, 10));

                // Convert 12-hour format to 24-hour format for comparison
                let hours24 = hours;
                if (period === 'PM' && hours !== 12) {
                    hours24 += 12;
                } else if (period === 'AM' && hours === 12) {
                    hours24 = 0;
                }

                // Check if showtime is in the past
                const showtimeDate = new Date();
                const now = new Date();
                showtimeDate.setHours(hours24, minutes, 0, 0);

                if (showtimeDate < now) {
                    showtimeBtn.classList.add('showtime-btn-disabled'); // Add disabled class
                    showtimeBtn.disabled = true; // Disable the button
                } else {
                    // Optional: Add click functionality to buttons if needed
                    showtimeBtn.addEventListener('click', () => {
                        showAppPopup();
                        // Add more functionality here if needed
                    });
                }

                showtimesWrapper.appendChild(showtimeBtn);
            });

            showtimesCell.appendChild(showtimesWrapper);
            newRow.appendChild(showtimesCell);

            tableBody.appendChild(newRow);
        }

        function showAppPopup() {
            const popup = document.getElementById('app-popup');
            popup.classList.remove('hide');
        }

        // Sample data for demonstration
        const movies = [
            { poster: 'images/insideout2.png', showtimes: '2:00 PM, 3:15 PM, 4:25 PM, 5:45 PM, 6:45 PM, 8:15 PM, 9:15 PM, 11:40 PM', title: 'INSIDE OUT 2', duration: '96 min', age: 'SU' },
            { poster: 'images/badboys.png', showtimes: '12:20 PM, 2:20 PM, 4:30 PM, 6:20 PM, 8:15 PM', title: 'BAD BOYS: RIDE OR DIE', duration: '93 min', age: '17+' },
            { poster: 'images/dilan.png', showtimes: '12:00 PM, 4:00 PM, 8:00 PM', title: 'DILAN 1983: WO AI NI', duration: '116 min', age: '13+' },
            { poster: 'images/grandma.png', showtimes: '1:10 PM, 1:35 PM, 2:25 PM, 2:45 PM, 4:45 PM, 5:15 PM, 6:15 PM, 7:40 PM', title: 'HOW TO MAKE MILLIONS BEFORE GRANDMA DIES', duration: '126 min', age: '13+' },
            { poster: 'images/garfield.png', showtimes: '1:20 PM, 2:20 PM, 4:30 PM, 5:20 PM, 6:15 PM, 8:20 PM', title: 'THE GARFIELD MOVIE', duration: '101 min', age: 'SU' },
            { poster: 'images/haikyu.png', showtimes: '2:05 PM, 3:20 PM, 4:10 PM, 5:05 PM, 6:20 PM, 7:10 PM', title: 'PAKU TANAH JAWA', duration: '100 min', age: '17+' },
            { poster: 'images/pakutanahjawa.png', showtimes: '1:20 PM, 2:15 PM, 4:25 PM, 5:45 PM, 6:25 PM, 8:35 PM, 9:15 PM, 9:40 PM', title: 'HAIKYU!! THE DUMPSTER BATTLE', duration: '86 min', age: '13+' },
            { poster: 'images/strangers.png', showtimes: '12:06 PM, 2:25 PM, 4:32 PM, 6:27 PM, 8:18 PM', title: 'THE STARNGERS: CHAPTER 1', duration: '116 min', age: '13+' },
            { poster: 'images/conan.png', showtimes: '12:20 PM, 4:02 PM, 8:03 PM, 7:03 PM', title: 'DETECTIVE CONAN VS KID THE PHANTOM THIEF', duration: '167 min', age: 'SU' },
            { poster: 'images/theplot.png', showtimes: '1:10 PM, 3:25 PM, 4:35 PM, 5:45 PM, 6:45 PM, 8:15 PM, 9:25 PM, 9:40 PM', title: 'THE PLOT', duration: '85 min', age: '13+' },
            { poster: 'images/ipar.png', showtimes: '12:20 PM, 2:20 PM, 4:30 PM, 6:20 PM, 8:15 PM', title: 'IPAR ADALAH MAUT', duration: '143 min', age: '17+' },
            { poster: 'images/sengkolo.png', showtimes: '12:00 PM, 4:20 PM, 8:50 PM', title: 'SENGKOLO: MALAM SATU SURO', duration: '125 min', age: '13+' }
        ];

        // Adding sample rows to the table
        movies.forEach(movie => {
            addMovieRow(movie.poster, movie.showtimes, movie.title, movie.duration, movie.age);
        });

        // Initial call
        updateClockAndDate();

        // Update every second
        setInterval(updateClockAndDate, 1000);
    </script>
</body>
</html>
