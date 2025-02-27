<%
	if(session.getAttribute("name")==null){
		response.sendRedirect("login.jsp");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Now - Cab Service</title>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }

        /* Header Styles */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background: #1d1f21;
            color: #fff;
        }
        .navbar a {
            color: #fff;
            text-decoration: none;
            padding: 10px 15px;
            font-size: 16px;
            font-weight: 500;
            transition: background 0.3s;
        }
        .navbar a:hover {
            background: #ff9800;
            border-radius: 5px;
        }

        .container {
            max-width: 1100px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* Flexbox Layout */
        .selection-container {
            display: flex;
            gap: 20px;
            align-items: flex-start;
        }

        .vehicle-selection {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            flex: 1;
        }

        .vehicle-option {
            padding: 15px;
            border-radius: 8px;
            background: #e0e0e0;
            cursor: pointer;
            text-align: center;
            transition: background 0.3s, transform 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            min-width: 80px;
            flex-grow: 1;
            max-width: 100px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .vehicle-option img {
            width: 40px;
            margin-bottom: 5px;
        }

        .vehicle-option.selected {
            background: #ff9800;
            color: white;
            transform: scale(1.05);
        }

        /* Vehicle Details */
        .vehicle-details {
            background: #fff;
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #ddd;
            width: 300px;
            min-width: 250px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .vehicle-info {
            display: flex;
            flex-direction: column;
        }

        .vehicle-info h3 {
            margin-bottom: 10px;
            font-size: 20px;
            text-align: center;
            font-weight: bold;
        }

        .vehicle-info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            padding: 10px 0;
        }

        .vehicle-info-grid p {
            font-size: 14px;
            margin: 0;
            display: flex;
            align-items: center;
            padding: 8px;
            background: #f8f8f8;
            border-radius: 5px;
        }

        .total-fare {
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            padding-top: 10px;
            background: #ff9800;
            color: white;
            border-radius: 5px;
            padding: 8px;
        }

        /* Booking Form */
        .booking-form {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        input, button {
            padding: 12px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        button {
            background: #1d1f21;
            color: white;
            cursor: pointer;
            transition: background 0.3s;
            max-width: 150px;
        }

        button:hover {
            background: #333;
        }

        /* Footer */
        .footer {
            background: #1d1f21;
            color: #fff;
            text-align: center;
            padding: 15px 0;
            margin-top: 50px;
        }

        @media screen and (max-width: 768px) {
            .selection-container {
                flex-direction: column;
            }
            .vehicle-details {
                width: 100%;
                margin-top: 10px;
            }
            .booking-form {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="navbar">
        <div class="logo">Cab Service</div>
        <div>
            <a href="index.jsp">Home</a>
            <a href="login"><%=session.getAttribute("name") %></a>
        </div>
    </div>

    <div class="container">
        <h2>Select a Vehicle</h2>
        
        <div class="selection-container">
            <div class="vehicle-selection">
                <div class="vehicle-option selected" data-vehicle="Budget" data-name="Suzuki Alto" data-passengers="4">
                    <img src="./images/alto.png" alt="Budget"> Budget
                </div>
                <div class="vehicle-option" data-vehicle="City" data-name="Suzuki Wagon R" data-passengers="4">
                    <img src="./images/wagonr.png" alt="City"> City
                </div>
                <div class="vehicle-option" data-vehicle="Car" data-name="Toyota Prius" data-passengers="5">
                    <img src="./images/sedan1.png" alt="Car"> Car
                </div>
                <div class="vehicle-option" data-vehicle="9 Seater" data-name="Toyota Kdh" data-passengers="9">
                    <img src="./images/kdh.png" alt="9 Seater"> 9 Seater
                </div>
                <div class="vehicle-option" data-vehicle="14 Seater" data-name="Toyota Hiace" data-passengers="14">
                    <img src="./images/kdh.png" alt="14 Seater"> 14 Seater
                </div>
            </div>

            <div class="vehicle-details">
                <div class="vehicle-info">
                    <h3 id="vehicle-name">Suzuki Alto</h3>
                    <div class="vehicle-info-grid">
                        <p>💳 Flexible Payment</p>
                        <p>❄️ Air Conditioned</p>
                        <p id="passenger-count">👤 4 passengers</p>
                        <p>🛄 Limited baggage</p>
                    </div>
                    <div class="total-fare">
                        Est. LKR 0.00
                    </div>
                </div>
            </div>
        </div>

        <div class="booking-form">
            <input type="text" placeholder="Pick Location">
            <input type="text" placeholder="Drop Location">
            <input type="datetime-local">
            <button>Book Now</button>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2025 Cab Service. All Rights Reserved.</p>
    </div>

    <script>
        document.querySelectorAll('.vehicle-option').forEach(option => {
            option.addEventListener('click', function() {
                document.querySelectorAll('.vehicle-option').forEach(opt => opt.classList.remove('selected'));
                this.classList.add('selected');
                document.getElementById('vehicle-name').innerText = this.getAttribute('data-name');
                document.getElementById('passenger-count').innerText = '👤 ' + this.getAttribute('data-passengers') + ' passengers';
            });
        });
    </script>

</body>
</html>
