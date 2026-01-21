<%-- 
    Document   : EventList
    Created on : Jan 16, 2026
    Author     : khoa9
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Event"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
<head>
    <title>Event List</title>
    <style>
        .page { 
            width: 100%; 
            max-width: 1200px; 
            margin: 0 auto; 
        }

        .welcome h1 { 
            display: flex; 
            justify-content: center; 
        }

        /* Dropdown */
        .wrapper { 
            position: relative; 
            width: 220px; 
            display: inline-block; 
            vertical-align: middle; 
        }
        
        .select-btn { 
            border: 1px solid #ccc; 
            padding: 6px 10px; 
            cursor: pointer; 
            background: #fff; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
        }

        .content { 
            position: absolute; 
            top: 100%; 
            left: 0; 
            width: 100%; 
            border: 1px solid #ccc; 
            background: #fff; 
            display: none; 
            z-index: 999; 
        }

        .wrapper.active .content { 
            display: block; 
        }

        /* Dropdown Search & Options */
        .options { 
            max-height: 180px; 
            overflow-y: auto; 
            padding: 0; 
            margin: 0; 
            list-style: none; 
            color: #000; 
        }

        .options li { 
            padding: 6px 10px; 
            cursor: pointer; 
        }

        .options li:hover { 
            background: #eee; 
        }
        
        .Filter { 
            display: flex; 
            align-items: center; 
            gap: 10px; 
            padding: 15px 0; 
            flex-wrap: wrap; 
        }

        .filter-box { 
            display: none;
            position: absolute;
            top: 19%; 
            padding: 10px; 
            border: 1px solid #ddd; 
            background: #f9f9f9;  
            width: max-content;
        }

        .filter-box input[type="number"], input[type="date"] { 
            width: 95px; 
        }

        .filter-box button { 
            margin-left: 10px; 
        }

        
        /* Search & Table */
        .search form { 
            display: flex; 
            justify-content: center;
            gap: 10px; 
            margin-bottom: 15px; 
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            table-layout: fixed; 
            margin-top: 20px; 
        }
        th, td { 
            border: 1px solid black; 
            padding: 8px; 
            text-align: center; 
        }
        .search input[type="text"], input[type="number"]{ 
            width: 40%; 
            box-sizing: border-box; 
        }
        button { 
            cursor: pointer; 
            padding: 5px 10px; 
        }

        input[type="text"]{ 
            width: 100%; 
            box-sizing: border-box; 
        }
    </style>
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("USER");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String fullName = currentUser.getFullName();
        String fullName = "";
        if (currentUser != null) {
            fullName = currentUser.getFullName();
        }
    %>
    <div class="page">
    <div class="welcome">
        <h1>Welcome, <%= fullName %>!</h1>
    </div>

    <div class="search">
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="Logout">Logout</button>
            <input class="searchinput" type="text" name="search" placeholder="Search">
            <button type="submit" name="action" value="Search">Search</button>
        </form>
        <form action="MainController" method="GET">
            <button type="submit" name="action" value="Add">Add New Event</button>
        </form>
    <% 
        ArrayList<Event> list = (ArrayList<Event>) request.getAttribute("list");
    %>
    
    <%
    session.removeAttribute("list");
    %>

    <div class="page">
        <div class="welcome">
            <h1>Welcome, <%= fullName %>!</h1>
        </div>
        
        <!-- Search Section -->
        <div class="search">
            <form action="MainController" method="POST">
                <button type="submit" name="action" value="Logout">Logout</button>
                <input class="searchinput" type="text" name="search" placeholder="Search event name...">
                <button type="submit" name="action" value="Search">Search</button>
            </form>
        </div>

        <!-- Filter Section and Event Table -->
        
        <div class="Filter">
            <form action="MainController" method="POST" id="locationForm">
                <div class="wrapper" id="locationWrapper">
                    <div class="select-btn">
                        <span>Select location</span>
                    </div>
                    <div class="content">
                        <input type="text" class="search-inner" placeholder="Search location">
                        <ul name="action" class="options"></ul>
                    </div>
                    </div>
                <input type="hidden" name="action" value="location">
                <input type="hidden" name="filterType" value="location">
                <input type="hidden" name="location" id="locationValue">
            </form>

            <button type="button" onclick="toggleFilter('dateBox')">Date</button>
            <button type="button" onclick="toggleFilter('priceBox')">Price</button><!-- comment -->
            <button type="button" onclick="toggleFilter('seatBox')">Seats</button>
            
            <div id="seatBox" class="filter-box">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="FilterSeats">
                    <input type="hidden" name="filterType" value="seats">
                    Seats ≥ <input type="number" name="minSeats" placeholder="0">
                    <button type="submit">Apply</button>
                </form>
            </div>

            
            <div id="dateBox" class="filter-box">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="FilterDate">
                    From: <input type="date" name="fromDate">
                    To: <input type="date" name="toDate">
                    <button type="submit">Apply</button>
                </form>
            </div>
            
            
            <div id="priceBox" class="filter-box">
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="FilterPrice">
                    Min:<input type="number" name="minPrice">
                    Max: <input type="number" name="maxPrice">
                    <button type="submit">Apply</button>
                </form>
            </div>

    <!-- Add button riêng -->
        <form action="MainController" method="POST" style="display:inline;">
            <button type="submit" name="action" value="Add">Add</button>
        </form>            
    
</div>
  
            <% if (list != null && !list.isEmpty()) { %>
            <!-- Event Table -->
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Price</th>
                        <th>Seats</th>
                        <th colspan="2">Feature</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    int count = 0;
                    for (Event event : list) {
                        count++;
                %>
                    <tr>
                        <form action="MainController" method="POST">
                            <td><%= count %></td>
                            <td><%= event.getEventID() %></td>
                            <td><input type="text" name="name" value="<%= event.getName() %>"></td>
                            <td><input type="text" name="location" value="<%= event.getLocation() %>"></td>
                            <td><input type="text" name="date" value="<%= event.getDate() %>"></td>
                            <td><input type="number" name="price" value="<%= event.getPrice() %>"></td>
                            <td><input type="number" name="availableSeats" value="<%= event.getAvailableSeats() %>"></td>
                            <td>
                                <input type="hidden" name="id" value="<%= event.getEventID() %>">
                                <button type="submit" name="action" value="Update">Update</button>
                            </td>
                        </form>
                        <td>
                            <form action="MainController" method="POST" onsubmit="return confirm('Delete this event?');">
                                <input type="hidden" name="id" value="<%= event.getEventID() %>">
                                <button type="submit" name="action" value="Delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% 
                    } 
                %>
                </tbody>
            </table>
        <% 
          } 
        %>

    </div>

    <script>
        // Toggle Filter Boxes
        function toggleFilter(id) {
            document.querySelectorAll('.filter-box').forEach(box => {
                box.style.display = (box.id === id && box.style.display !== 'block') ? 'block' : 'none';
            });
        }

        // Location Dropdown Logic
        const wrapper = document.getElementById("locationWrapper");
            
        const selectBtn = wrapper.querySelector(".select-btn");  
        const searchInp = wrapper.querySelector(".search-inner");
        const options = wrapper.querySelector(".options");
   
        

        // Extract locations from sql
        <%
            ArrayList<String> locs = new ArrayList<>();
            if (list != null) {
                for (Event e : list) {
                    if (!locs.contains(e.getLocation())) locs.add(e.getLocation());
                }
            }
        %>
        const locations = [
            <% for (int i=0; i<locs.size(); i++) { %>
                "<%= locs.get(i) %>"
                <%= i < locs.size()-1 ? "," : "" %>
            <% } %>];

        // Populate location options
        function addLocation(selectedLocation = "") {
            options.innerHTML = "";
        
            if (locations.length === 0) {
                options.innerHTML = '<p>No locations available</p>';
                return;
            }

            locations.forEach(loc => {
                const isSelected = (loc === selectedLocation) ? "active" : "";
                const li = document.createElement("li");
                li.textContent = loc;
                li.onclick = () => updateLocation(li);
                if (isSelected) li.classList.add("active");
                options.appendChild(li);
            });
        %>                
    </table>
    </div>
    <h2>Add New Event</h2>
    
    <%   
        }

        addLocation();

        // Update selected location
        function updateLocation(selectedLi) {
            const value = selectedLi.textContent;
            selectBtn.firstElementChild.textContent = value;
            document.getElementById("locationValue").value = value;
            wrapper.classList.remove("active");
            const form = wrapper.closest("form");
            form.submit();
        }

        // Filter locations search
        searchInp.addEventListener("keyup", () => {
            let filter = searchInp.value.toLowerCase().trim();
            let res = locations
                .filter(data => data.toLowerCase().includes(filter))
                .map(data => {
                    const li = document.createElement("li");
                    li.textContent = data;
                    li.onclick = () => updateLocation(li);
                    return li;
                });
            options.innerHTML = "";
            if (res.length === 0) {
                options.innerHTML = '<p>No locations available</p>';
            } else {
                res.forEach(li => options.appendChild(li));
            }
        });
        
        // Toggle dropdown on select button click
        selectBtn.addEventListener("click", () => {
            wrapper.classList.toggle("active");
            if (wrapper.classList.contains("active")) {
                searchInp.focus();
            }
        });
    </script>
</body>
</html>