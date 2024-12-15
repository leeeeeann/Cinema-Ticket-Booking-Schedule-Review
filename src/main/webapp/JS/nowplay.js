 const urlParams = new URLSearchParams(window.location.search);
    const movie = urlParams.get('movie');
    const movies = {
        insideout2: {
            trailer: 'https://www.youtube.com/embed/LEjhY15eCx0?start=1',
            title: 'INSIDE OUT 2',
            duration: '96 min',
            rating: '4.5 *',
            ageRating: 'SU',
            synopsis: `This adventure will take you into the complicated world of emotions. Along with the emotions of Joy, Sadness, Anger, Fear, and Disgust, Riley now also faces Anxiety, a new emotion with an orange color. The presence of Anxiety in Riley's headquarters adds drama to the emotionalÂ controlÂ room.`
        } 
    };

    //privacy policy
const privacyPolicyLink = document.getElementById('privacy-policy-link');
const popupForm = document.getElementById('privacy-policy');
const closeBtn = document.querySelector('.close-btn');


privacyPolicyLink.addEventListener('click', function(event) {
    event.preventDefault();
    popupForm.classList.remove('hide');
});


closeBtn.addEventListener('click', function() {
    popupForm.classList.add('hide');
});


window.addEventListener('click', function(event) {
    if (event.target === popupForm) {
        popupForm.classList.add('hide');
    }
});


    document.querySelector('#title').textContent = movies[movie].title;
    document.querySelector('iframe').src = movies[movie].trailer;
    document.querySelector('#details').textContent = `${movies[movie].duration} | ${movies[movie].rating} | ${movies[movie].ageRating}`;
    document.querySelector('.righter p').textContent = movies[movie].synopsis;

    document.getElementById('schedule').addEventListener('click', function() {
        window.location.href = 'index.jsp#theaters';
    });

    $(document).ready(function() {
    const urlParams = new URLSearchParams(window.location.search);
    const movie = urlParams.get('movie');

    function loadReviews(movieId) {
        var reviews = JSON.parse(localStorage.getItem('movieReviews')) || [];
        var reviewsContainer = $('#reviews');
        reviewsContainer.empty();
        reviews.forEach(function(review) {
            if (review.movie === movieId && review.rating !== '1') { // Filter out reviews with 1 star rating
                var newReview = $('<div></div>').addClass('review');
                newReview.html(`<strong>${review.name}</strong> rated <strong>${review.rating}</strong> stars<br>${review.feedback}`);
                reviewsContainer.append(newReview);
            }
        });
    }

    loadReviews(movie);

    $('#reviewForm').on('submit', function(event) {
        event.preventDefault(); 

        var name = $('#name').val();
        var rating = $('#rating').val();
        var feedback = $('#feedback').val();

        if (rating == null) {
            alert('Please select a valid rating.');
            return;
        }

        // Save review to local storage with movie identifier
        var reviews = JSON.parse(localStorage.getItem('movieReviews')) || [];
        var review = {
            movie: movie,
            name: name,
            rating: rating,
            feedback: feedback
        };
        reviews.push(review);
        localStorage.setItem('movieReviews', JSON.stringify(reviews));

        // Clear the form fields
        $('#name').val('');
        $('#rating').val('1');
        $('#feedback').val('');

        // Reload reviews for the current movie
        loadReviews(movie);
    });
});

 // Function to toggle the submit review button appearance based on login status
function toggleSubmitReviewButton() {
    const isLoggedIn = localStorage.getItem('isLoggedIn');
    const submitReviewButton = document.getElementById('submit-review-button');

    if (isLoggedIn) {
        submitReviewButton.classList.remove('disabled');
    } else {
        submitReviewButton.classList.add('disabled');
    }
}

// Show login required popup
function showLoginRequiredPopup() {
    document.getElementById('login-required-popup').classList.add('show');
}

// Close popup
function closePopup(element) {
    const popupForm = element.closest('.popup-form');
    popupForm.classList.remove('show');
    
    if (popupForm.id === 'login-popup') {
        resetLoginForm();
    }
}

// Add event listener for the submit review button
document.getElementById('submit-review-button').addEventListener('click', function(event) {
    const isLoggedIn = localStorage.getItem('isLoggedIn');
    if (!isLoggedIn) {
        event.preventDefault();
        showLoginRequiredPopup();
    }
});

// Add event listeners for closing the popup
document.querySelectorAll('.close-btn').forEach(function(btn) {
    btn.addEventListener('click', function() {
        closePopup(btn);
    });
});

window.addEventListener('click', function(event) {
    if (event.target.classList.contains('popup-form')) {
        event.target.classList.remove('show');
    }
});

// Call the toggleSubmitReviewButton function on page load
document.addEventListener('DOMContentLoaded', function() {
    toggleSubmitReviewButton();
    checkLoginStatus();
});

// Function to check login status
function checkLoginStatus() {
    const isLoggedIn = localStorage.getItem('isLoggedIn');
    const myMtixBtn = document.getElementById('my-mtix-btn');
    const myMtixDropdown = document.getElementById('my-mtix-dropdown');

    if (isLoggedIn) {
        myMtixBtn.innerHTML = '<i class="fa-solid fa-user"></i>';
        myMtixDropdown.innerHTML = `
            <a href="#" id="logout-link"><i class="fa-solid fa-sign-out"></i> Logout</a>
        `;

        document.getElementById('logout-link').addEventListener('click', function(event) {
            event.preventDefault();
            localStorage.removeItem('isLoggedIn');
            myMtixBtn.innerHTML = 'My M-tix';
            myMtixDropdown.innerHTML = `
                <a href="#" id="login-link"><i class="fa-solid fa-sign-in"></i> Login</a>
            `;
            setupLoginLink();
        });
    } else {
        myMtixBtn.innerHTML = 'My M-tix';
        myMtixDropdown.innerHTML = `
            <a href="#" id="login-link"><i class="fa-solid fa-sign-in"></i> Login</a>
        `;
        setupLoginLink();
    }
}

// Function to setup login link
function setupLoginLink() {
    document.getElementById('login-link').addEventListener('click', function(event) {
        event.preventDefault();
        showLoginPopup();
    });
}

// Initial setup
document.addEventListener('DOMContentLoaded', function() {
    toggleSubmitReviewButton();
    checkLoginStatus();
});