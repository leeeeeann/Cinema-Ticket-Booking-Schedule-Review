document.addEventListener("DOMContentLoaded", function() {
    let slideIndex = 1;
    showSlides(slideIndex);
    
    function moveSlide(n) {
        showSlides(slideIndex += n);
    }
    
    function showSlides(n) {
        let i;
        let slides = document.getElementsByClassName("slide");
        if (n > slides.length) {slideIndex = 1}    
        if (n < 1) {slideIndex = slides.length}
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";  
        }
        slides[slideIndex-1].style.display = "block";  
    }
    
    // Attach moveSlide to the global scope so buttons can call it
    window.moveSlide = moveSlide;
});


	
	
	function toggleDropdown() {
	    document.getElementById("dropdown-content").classList.toggle("show");
	}
	
	function filterFunction() {
	    var input, filter, a, i;
	    input = document.getElementById("search");
	    filter = input.value.toUpperCase();
	    div = document.getElementById("dropdown-content");
	    a = div.getElementsByTagName("a");
	    for (i = 0; i < a.length; i++) {
	        txtValue = a[i].textContent || a[i].innerText;
	        if (txtValue.toUpperCase().indexOf(filter) > -1) {
	            a[i].style.display = "";
	        } else {
	            a[i].style.display = "none";
	        }
	    }
	}
	
	const cinemaData = {
	    "JAKARTA": [
	        "Plaza Indonesia ",
	        "Kota Kasablanka ",
	        "Senayan City ",
	        "Mall Kelapa Gading ",
	        "Pondok Indah Mall ",
	        "Taman Anggrek ",
	        "Blok M Plaza ",
	
	    ],
	    "BOGOR": [
	        "Botani Square ",
	        "Bogor Trade Mall",
	        "Cibinong City Mall"
	    ],
	    "DEPOK": [
	        "Depok Town Square",
	        "Margo City ",
	        "Pesona Square "
	    ],
	    "TANGERANG": [
	        "AEON Mall BSD City ",
	        "Summarecon Mall Serpong ",
	        "Living World ",
	        "Supermal Karawaci"
	    ],
	    "BEKASI": [
	        "Summarecon Mall Bekasi ",
	        "Metropolitan Mall Bekasi",
	        "Grand Galaxy Park",
	        "Lagoon Avenue Mall "
	    ]
	
	};
	
	
	
	function showCinemas() {
	    const city = document.getElementById("city-select").value;
	    const cinemaListDiv = document.getElementById("cinema-list");
	    cinemaListDiv.innerHTML = "";
	
	    if (cinemaData[city]) {
	        const table = document.createElement("table");
	        table.className = "cinema-table";
	
	        const headerRow = document.createElement("tr");
	        const headerCinema = document.createElement("th");
	        headerCinema.textContent = "Cinema";
	        headerRow.appendChild(headerCinema);
	        table.appendChild(headerRow);
	
	        cinemaData[city].forEach(cinema => {
	            const row = document.createElement("tr");
	            const cell = document.createElement("td");
	
	            const link = document.createElement("a");
	            link.href = `cinemaschedule.jsp?cinema=${encodeURIComponent(cinema)}`; // Link to cinemaschedule.html with cinema parameter
	            link.textContent = cinema;
	
	            cell.appendChild(link);
	            row.appendChild(cell);
	            table.appendChild(row);
	        });
	
	        cinemaListDiv.appendChild(table);
	    }
	}
	
	
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
	
	   // Menyimpan referensi elemen dropdown
	   var myMtixDropdown = document.getElementById("my-mtix-dropdown");
	
	   // Menambahkan event listener untuk menampilkan form login ketika "Login" dipilih
	   myMtixDropdown.addEventListener("click", function(event) {
	     event.stopPropagation(); // Mencegah penutupan dropdown saat diklik
	     if (event.target.id === "login-link") {
	       showLoginPopup();
	     }
	   });
	
	// Menampilkan popup login
	function showLoginPopup() {
	    document.getElementById("login-popup").classList.remove("hide");
	    resetLoginForm(); // Memastikan form login kosong saat popup ditampilkan
	}
	
	// Menutup popup
	function closePopup(element) {
	    const popupForm = element.closest('.popup-form');
	    popupForm.classList.add('hide');
	    
	    // Jika yang ditutup adalah popup login, reset form login
	    if (popupForm.id === 'login-popup') {
	        resetLoginForm();
	    }
	}
	
	// Fungsi untuk mengosongkan form login
	function resetLoginForm() {
	    document.getElementById('login-email').value = '';
	    document.getElementById('login-password').value = '';
	}
	
	// Fungsi untuk validasi email
	function validateEmail(email) {
	    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    return re.test(String(email).toLowerCase());
	}
	
	// Fungsi untuk validasi login
	function validateLogin(email, password) {
	    const validEmail = 'admin';
	    const validPassword = '1234';
	    return email === validEmail && password === validPassword;
	}
	
	let loginAttempts = 0; // Variabel untuk menghitung jumlah percobaan login
	
	// Event listener untuk tombol My Mtix untuk menampilkan formulir popup login
	document.getElementById('my-mtix-btn').addEventListener('click', function(event) {
	    event.preventDefault();
	    showLoginPopup();
	});
	
	// Event listener untuk menutup formulir popup ketika tombol close diklik
	document.querySelectorAll('.close-btn').forEach(function(btn) {
	    btn.addEventListener('click', function() {
	        closePopup(btn);
	    });
	});
	
	// Event listener untuk menutup formulir popup ketika mengklik di luar popup
	window.addEventListener('click', function(event) {
	    if (event.target.classList.contains('popup-form')) {
	        event.target.classList.add('hide');
	    }
	});
	
	// Event listener untuk link "Register now" untuk menampilkan formulir popup register
	document.getElementById('register-link').addEventListener('click', function(event) {
	    event.preventDefault();
	    document.getElementById("login-popup").classList.add('hide');
	    document.getElementById("register-popup").classList.remove('hide');
	});
	
	// Event listener untuk form register
	document.getElementById('register-form').addEventListener('submit', function(event) {
	    event.preventDefault();
	    
	    const email = document.getElementById('register-email').value;
	    
	    if (validateEmail(email)) {
	        document.getElementById("register-popup").classList.add('hide');
	        document.getElementById("successregistPopup").classList.remove('hide');
	        resetRegisterForm(); // Kosongkan form setelah registrasi berhasil
	    } else {
	        alert('Please enter a valid email address.');
	    }
	});
	
	// Event listener untuk form login
	document.getElementById('login-form').addEventListener('submit', function(event) {
	    event.preventDefault();
	    
	    const email = document.getElementById('login-email').value;
	    const password = document.getElementById('login-password').value;
	    
	    if (validateLogin(email, password)) {
	        document.getElementById("login-popup").classList.add('hide');
	        document.getElementById("successloginPopup").classList.remove('hide');
	        resetLoginForm(); // Kosongkan form setelah login berhasil
	        
	        // Ganti tombol My M-tix dengan ikon pengguna setelah login berhasil
	        const myMtixBtn = document.getElementById('my-mtix-btn');
	        myMtixBtn.innerHTML = '<i class="fa-solid fa-user"></i>';
	        
	        // Tambahkan dropdown content untuk logout
	        const myMtixDropdown = document.getElementById('my-mtix-dropdown');
	        myMtixDropdown.innerHTML = `
	            <a href="#" id="logout-link"><i class="fa-solid fa-sign-out"></i> Logout</a>
	        `;
	        
	        localStorage.setItem('isLoggedIn', 'true');
	
	        // Event listener untuk logout
	        document.getElementById('logout-link').addEventListener('click', function(event) {
	            event.preventDefault();
	            // Lakukan logika untuk logout di sini
	            
	            // Setelah logout, reset tombol My M-tix ke awal
	            myMtixBtn.innerHTML = 'My M-tix';
	            myMtixDropdown.innerHTML = `
	                <a href="#" id="login-link"><i class="fa-solid fa-sign-in"></i> Login</a>
	            `;
	        });
	    } else {
	        loginAttempts++; // Tambahkan jumlah percobaan login
	        
	        if (loginAttempts >= 3) {
	            document.getElementById("login-popup").classList.add('hide');
	            document.getElementById("failedloginmaxPopup").classList.remove('hide');
	            loginAttempts = 0; // Reset jumlah percobaan setelah mencapai batas maksimum
	        } else {
	            const loginFailedPopup = document.getElementById("failedloginPopup");
	            loginFailedPopup.classList.remove('hide');
	            loginFailedPopup.querySelector('p').textContent = 'Invalid Email or Password'; // Ubah pesan error
	            resetLoginForm(); // Kosongkan form setelah login gagal
	        }
	    }
	});
	
	// Panggil fungsi ini saat halaman dimuat
	document.addEventListener('DOMContentLoaded', function() {
	    checkLoginStatus();
	    
	    function checkLoginStatus() {
	        const isLoggedIn = localStorage.getItem('isLoggedIn');
	        if (isLoggedIn) {
	            const myMtixBtn = document.getElementById('my-mtix-btn');
	            myMtixBtn.innerHTML = '<i class="fa-solid fa-user"></i>';
	            
	            const myMtixDropdown = document.getElementById('my-mtix-dropdown');
	            myMtixDropdown.innerHTML = `
	                <a href="#" id="logout-link"><i class="fa-solid fa-sign-out"></i> Logout</a>
	            `;
	    
	            document.getElementById('logout-link').addEventListener('click', function(event) {
	                event.preventDefault();
	                // Lakukan logika untuk logout di sini
	                
	                // Hapus status login dari localStorage
	                localStorage.removeItem('isLoggedIn');
	    
	                // Setelah logout, reset tombol My M-tix ke awal
	                myMtixBtn.innerHTML = 'My M-tix';
	                myMtixDropdown.innerHTML = `
	                    <a href="#" id="login-link"><i class="fa-solid fa-sign-in"></i> Login</a>
	                `;
	            });
	        }
	    }
	    
	});
	
