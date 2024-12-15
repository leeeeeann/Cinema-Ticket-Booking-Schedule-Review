
	
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