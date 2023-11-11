
CREATE TABLE `Bitacora` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Description` varchar(200) DEFAULT NULL,
  `ActionDate` date DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Booking` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ClientId` int NOT NULL,
  `BookingDate` date NOT NULL,
  `Seats` int NOT NULL,
  `Destination` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FKClient_idx` (`ClientId`),
  KEY `FKDestination_idx` (`Destination`),
  CONSTRAINT `FKClient` FOREIGN KEY (`ClientId`) REFERENCES `Client` (`Id`),
  CONSTRAINT `FKDestination` FOREIGN KEY (`Destination`) REFERENCES `Destination` (`Destination`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Client` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(100) NOT NULL,
  `PassportNumber` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Destination` (
  `Destination` varchar(100) NOT NULL,
  `TravelDate` date DEFAULT NULL,
  `AvailableSeats` int DEFAULT NULL,
  PRIMARY KEY (`Destination`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DELIMITER $$
CREATE DEFINER=`admin`@`%` PROCEDURE `strpClient`(
IN name varchar(100),
IN lastName varchar(100),
IN email varchar(100),
IN phone varchar(100),
IN passportNumber varchar(100)
)
BEGIN
	DECLARE cliend_id INT; 
		INSERT INTO Client(Name,LastName,Email,Phone,PassportNumber)
		VALUES(Name,lastName,email,phone,passportNumber);
		set cliend_id = LAST_INSERT_ID();
    SELECT cliend_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`admin`@`%` PROCEDURE `strpGetAvailability`(
IN bookingDate date,
IN seats int,
IN destination varchar(100)
)
BEGIN
	SELECT (AvailableSeats - seats) FROM Destination WHERE Destination = destination AND TravelDate = bookingDate;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`admin`@`%` PROCEDURE `strpSaveBooking`(
/*IN name varchar(100),
IN lastName varchar(100),
IN email varchar(100),
IN phone varchar(100),
IN passportNumber varchar(100),*/
IN clientId int,
IN bookingDate date,
IN seats int,
IN destination varchar(100)
)
BEGIN
DECLARE booking_id INT; 

        INSERT INTO Booking(ClientId,BookingDate,Seats,Destination)
        VALUES(clientId,bookingDate,seats,destination);
        SET booking_id= last_insert_id();
        UPDATE Destination SET AvailableSeats = (AvailableSeats -seats)  WHERE Destination = destination AND TravelDate = bookingDate;
        SELECT booking_id;
END$$
DELIMITER ;
