-- ============================================================
-- ASPIRE FITNESS DATABASE - COMPLETE SCRIPT
-- WITH NEPALI NAMES THROUGHOUT
-- ============================================================

CREATE DATABASE GYM;
USE GYM;

-- ============================================================
-- CREATE TABLE STATEMENTS
-- ============================================================

-- 1. Member Table
CREATE TABLE Member (
    MemberId       INT(10)       NOT NULL AUTO_INCREMENT,
    FirstName      VARCHAR(50)   NOT NULL,
    Surname        VARCHAR(50)   NOT NULL,
    Address        VARCHAR(100)  NULL,
    PhoneNumber    VARCHAR(20)   NOT NULL UNIQUE,
    Email          VARCHAR(100)  NOT NULL UNIQUE,
    DateOfBirth    DATE          NOT NULL,
    MedicalNotes   VARCHAR(255)  NULL,
    PRIMARY KEY (MemberId)
);

-- 2. Staff Table
CREATE TABLE Staff (
    StaffId       INT(10)      NOT NULL AUTO_INCREMENT,
    FirstName     VARCHAR(50)  NOT NULL,
    Surname       VARCHAR(50)  NOT NULL,
    Role          VARCHAR(50)  NULL,
    PhoneNumber   VARCHAR(20)  NOT NULL UNIQUE,
    PRIMARY KEY (StaffId)
);

-- 3. Class Table
CREATE TABLE Class (
    ClassId        INT(10)      NOT NULL AUTO_INCREMENT,
    ClassName      VARCHAR(50)  NOT NULL,
    InstructorId   INT(10)      NOT NULL,
    MaxClassSize   INT(10)      NOT NULL,
    StaffStaffId   INT(10)      NOT NULL,
    PRIMARY KEY (ClassId),
    CONSTRAINT fk_Class_Staff
        FOREIGN KEY (StaffStaffId) REFERENCES Staff(StaffId)
);

-- 4. ClassSchedule Table
CREATE TABLE ClassSchedule (
    ScheduleId    INT(10)      NOT NULL AUTO_INCREMENT,
    ClassId       INT(10)      NOT NULL,
    Day           VARCHAR(20)  NOT NULL,
    Time          TIME         NOT NULL,
    ClassClassId  INT(10)      NOT NULL,
    PRIMARY KEY (ScheduleId),
    CONSTRAINT fk_ClassSchedule_Class
        FOREIGN KEY (ClassClassId) REFERENCES Class(ClassId)
);

-- 5. Facility Table
CREATE TABLE Facility (
    FacilityId    INT(10)      NOT NULL AUTO_INCREMENT,
    FacilityName  VARCHAR(50)  NOT NULL UNIQUE,
    MaxCapacity   INT(10)      NOT NULL,
    PRIMARY KEY (FacilityId)
);

-- 6. ClassBooking Table
CREATE TABLE ClassBooking (
    ClassBookingId            INT      NOT NULL AUTO_INCREMENT,
    MemberId                  INT      NOT NULL,
    ScheduleId                INT      NOT NULL,
    BookingDate               DATE     NOT NULL,
    MemberMemberId            INT(10)  NOT NULL,
    ClassScheduleScheduleId   INT(10)  NOT NULL,
    PRIMARY KEY (ClassBookingId),
    CONSTRAINT fk_ClassBooking_Member
        FOREIGN KEY (MemberMemberId) REFERENCES Member(MemberId),
    CONSTRAINT fk_ClassBooking_Schedule
        FOREIGN KEY (ClassScheduleScheduleId) REFERENCES ClassSchedule(ScheduleId)
);

-- 7. FacilityBooking Table
CREATE TABLE FacilityBooking (
    BookingId           INT(10)  NOT NULL AUTO_INCREMENT,
    MemberId            INT(10)  NOT NULL,
    FacilityId          INT(10)  NOT NULL,
    BookingDate         DATE     NOT NULL,
    StartTime           TIME     NOT NULL,
    EndTime             TIME     NOT NULL,
    MemberMemberId      INT(10)  NOT NULL,
    FacilityFacilityId  INT(10)  NOT NULL,
    PRIMARY KEY (BookingId),
    CONSTRAINT fk_FacilityBooking_Member
        FOREIGN KEY (MemberMemberId) REFERENCES Member(MemberId),
    CONSTRAINT fk_FacilityBooking_Facility
        FOREIGN KEY (FacilityFacilityId) REFERENCES Facility(FacilityId),
    CONSTRAINT chk_MaxTwoHourSlot
        CHECK (TIMEDIFF(EndTime, StartTime) <= '02:00:00')
);

-- 8. Membership Table
CREATE TABLE Membership (
    MembershipId    INT(10)       NOT NULL AUTO_INCREMENT,
    MemberId        INT(10)       NOT NULL,
    WeeklyFee       DECIMAL(6,2)  NOT NULL DEFAULT 10.00,
    StartDate       DATE          NOT NULL,
    Status          VARCHAR(20)   NOT NULL DEFAULT 'Active',
    MemberMemberId  INT(10)       NOT NULL,
    PRIMARY KEY (MembershipId),
    CONSTRAINT fk_Membership_Member
        FOREIGN KEY (MemberMemberId) REFERENCES Member(MemberId)
);

-- 9. ExtraFee Table
CREATE TABLE ExtraFee (
    FeeId    INT(10)       NOT NULL AUTO_INCREMENT,
    FeeType  VARCHAR(50)   NOT NULL UNIQUE,
    Amount   DECIMAL(6,2)  NOT NULL,
    PRIMARY KEY (FeeId)
);

-- 10. MemberFee Table
CREATE TABLE MemberFee (
    MemberFeeId      INT(10)  NOT NULL AUTO_INCREMENT,
    MemberId         INT(10)  NOT NULL,
    FeeId            INT(10)  NOT NULL,
    DateCharged      DATE     NOT NULL,
    MemberMemberId   INT(10)  NOT NULL,
    ExtraFeeFeeId    INT(10)  NOT NULL,
    PRIMARY KEY (MemberFeeId),
    CONSTRAINT fk_MemberFee_Member
        FOREIGN KEY (MemberMemberId) REFERENCES Member(MemberId),
    CONSTRAINT fk_MemberFee_ExtraFee
        FOREIGN KEY (ExtraFeeFeeId) REFERENCES ExtraFee(FeeId)
);


-- ============================================================
-- INSERT STATEMENTS
-- ============================================================

-- ── Members (13 Total) ────────────────────────────────────────
INSERT INTO Member (FirstName, Surname, Address, PhoneNumber, Email, DateOfBirth, MedicalNotes)
VALUES
    ('Anisha',   'Shrestha',   '14 Everest Close, Bedford',       '07700900001', 'anisha.shrestha@email.com',   '1995-03-12', NULL),
    ('Alina',    'Tamang',     '27 Kathmandu Road, Luton',         '07700900002', 'alina.tamang@email.com',      '1998-07-08', NULL),
    ('Soniya',   'Gurung',     '9 Pokhara Lane, Milton Keynes',    '07700900003', 'soniya.gurung@email.com',     '1993-11-25', 'Mild back pain'),
    ('Arpit',    'Adhikari',   '33 Himalaya Street, Bedford',      '07700900004', 'arpit.adhikari@email.com',    '1991-05-14', NULL),
    ('Riwaj',    'Karki',      '55 Mustang Avenue, Dunstable',     '07700900005', 'riwaj.karki@email.com',       '1996-09-30', NULL),
    ('Pratik',   'Thapa',      '18 Lumbini Drive, Luton',          '07700900006', 'pratik.thapa@email.com',      '1994-01-19', NULL),
    ('Luna',     'Maharjan',   '42 Boudha Close, Milton Keynes',   '07700900007', 'luna.maharjan@email.com',     '1997-06-03', NULL),
    ('Drishti',  'Basnet',     '7 Annapurna Road, Bedford',        '07700900008', 'drishti.basnet@email.com',    '1999-04-21', NULL),
    ('Sanjog',   'Rai',        '22 Pashupatinath Ave, Luton',      '07700900009', 'sanjog.rai@email.com',        '1990-08-15', NULL),
    ('Bibek',    'Poudel',     '11 Trishuli Road, Bedford',        '07700900010', 'bibek.poudel@email.com',      '1992-12-05', 'Mild asthma'),
    ('Kriti',    'Koirala',    '36 Bagmati Lane, Dunstable',       '07700900011', 'kriti.koirala@email.com',     '1997-03-28', NULL),
    ('Roshan',   'Bajracharya','19 Swayambhu Street, Milton Keynes','07700900012','roshan.bajracharya@email.com','1989-07-17', 'Knee injury'),
    ('Nischal',  'Joshi',      '5 Chitwan Close, Bedford',         '07700900013', 'nischal.joshi@email.com',     '1994-10-09', NULL);


-- ── Staff (8 Nepali Staff) ────────────────────────────────────
INSERT INTO Staff (FirstName, Surname, Role, PhoneNumber)
VALUES
    ('Sabina',   'Magar',      'Class Instructor',  '07800100001'),
    ('Dipesh',   'Limbu',      'Personal Trainer',  '07800100002'),
    ('Kamana',   'Bhandari',   'Class Instructor',  '07800100003'),
    ('Suraj',    'Hamal',      'Gym Staff',         '07800100004'),
    ('Nisha',    'Pandey',     'Manager',           '07800100005'),
    ('Bikash',   'Subedi',     'Personal Trainer',  '07800100006'),
    ('Samjhana', 'Neupane',    'Class Instructor',  '07800100007'),
    ('Anil',     'Dhakal',     'Administration',    '07800100008');


-- ── Classes (5 Classes) ───────────────────────────────────────
INSERT INTO Class (ClassName, InstructorId, MaxClassSize, StaffStaffId)
VALUES
    ('Yoga',     1, 25, 1),   -- Taught by Sabina Magar
    ('Zumba',    3, 25, 3),   -- Taught by Kamana Bhandari
    ('Pilates',  1, 20, 1),   -- Taught by Sabina Magar
    ('Tai Chi',  7, 15, 7),   -- Taught by Samjhana Neupane
    ('Dance',    3, 10, 3);   -- Taught by Kamana Bhandari


-- ── Class Schedules ───────────────────────────────────────────
INSERT INTO ClassSchedule (ClassId, Day, Time, ClassClassId)
VALUES
    (1, 'Monday',    '09:00:00', 1),   -- Yoga
    (2, 'Tuesday',   '18:30:00', 2),   -- Zumba
    (3, 'Wednesday', '10:00:00', 3),   -- Pilates
    (4, 'Thursday',  '17:00:00', 4),   -- Tai Chi
    (5, 'Friday',    '11:00:00', 5);   -- Dance


-- ── Facilities ────────────────────────────────────────────────
INSERT INTO Facility (FacilityName, MaxCapacity)
VALUES
    ('Main Hall',        80),
    ('Yoga Hall',        25),
    ('Small Dance Room', 10);


-- ── Class Bookings (all 13 members) ──────────────────────────
INSERT INTO ClassBooking (MemberId, ScheduleId, BookingDate, MemberMemberId, ClassScheduleScheduleId)
VALUES
    (1,  1, '2026-03-16', 1,  1),   -- Anisha  – Monday Yoga
    (2,  2, '2026-03-17', 2,  2),   -- Alina   – Tuesday Zumba
    (3,  3, '2026-03-18', 3,  3),   -- Soniya  – Wednesday Pilates
    (4,  4, '2026-03-19', 4,  4),   -- Arpit   – Thursday Tai Chi
    (5,  5, '2026-03-20', 5,  5),   -- Riwaj   – Friday Dance
    (6,  1, '2026-03-23', 6,  1),   -- Pratik  – Monday Yoga
    (7,  2, '2026-03-24', 7,  2),   -- Luna    – Tuesday Zumba
    (8,  3, '2026-03-25', 8,  3),   -- Drishti – Wednesday Pilates
    (9,  4, '2026-03-26', 9,  4),   -- Sanjog  – Thursday Tai Chi
    (10, 5, '2026-03-27', 10, 5),   -- Bibek   – Friday Dance
    (11, 1, '2026-03-23', 11, 1),   -- Kriti   – Monday Yoga
    (12, 3, '2026-03-25', 12, 3),   -- Roshan  – Wednesday Pilates
    (13, 2, '2026-03-24', 13, 2);   -- Nischal – Tuesday Zumba


-- ── Facility Bookings (all 13 members) ───────────────────────
INSERT INTO FacilityBooking (MemberId, FacilityId, BookingDate, StartTime, EndTime, MemberMemberId, FacilityFacilityId)
VALUES
    (1,  1, '2026-03-16', '14:00:00', '16:00:00', 1,  1),  -- Anisha  – Main Hall        2hr
    (2,  2, '2026-03-17', '10:00:00', '11:00:00', 2,  2),  -- Alina   – Yoga Hall        1hr
    (3,  3, '2026-03-18', '13:00:00', '14:00:00', 3,  3),  -- Soniya  – Small Dance Room 1hr
    (4,  1, '2026-03-19', '09:00:00', '11:00:00', 4,  1),  -- Arpit   – Main Hall        2hr
    (5,  2, '2026-03-20', '15:00:00', '16:30:00', 5,  2),  -- Riwaj   – Yoga Hall        1.5hr
    (6,  1, '2026-03-23', '10:00:00', '12:00:00', 6,  1),  -- Pratik  – Main Hall        2hr
    (7,  2, '2026-03-24', '11:00:00', '12:00:00', 7,  2),  -- Luna    – Yoga Hall        1hr
    (8,  3, '2026-03-25', '14:00:00', '15:30:00', 8,  3),  -- Drishti – Small Dance Room 1.5hr
    (9,  1, '2026-03-26', '13:00:00', '15:00:00', 9,  1),  -- Sanjog  – Main Hall        2hr
    (10, 2, '2026-03-27', '09:00:00', '10:00:00', 10, 2),  -- Bibek   – Yoga Hall        1hr
    (11, 1, '2026-03-23', '16:00:00', '17:30:00', 11, 1),  -- Kriti   – Main Hall        1.5hr
    (12, 3, '2026-03-25', '10:00:00', '11:00:00', 12, 3),  -- Roshan  – Small Dance Room 1hr
    (13, 2, '2026-03-24', '13:00:00', '14:30:00', 13, 2);  -- Nischal – Yoga Hall        1.5hr


-- ── Memberships (all 13 members) ─────────────────────────────
INSERT INTO Membership (MemberId, WeeklyFee, StartDate, Status, MemberMemberId)
VALUES
    (1,  10.00, '2026-01-05', 'Active', 1),
    (2,  10.00, '2026-01-12', 'Active', 2),
    (3,  10.00, '2026-02-01', 'Active', 3),
    (4,  10.00, '2026-02-07', 'Active', 4),
    (5,  10.00, '2026-02-14', 'Active', 5),
    (6,  10.00, '2026-02-21', 'Active', 6),
    (7,  10.00, '2026-03-01', 'Active', 7),
    (8,  10.00, '2026-03-02', 'Active', 8),
    (9,  10.00, '2026-03-03', 'Active', 9),
    (10, 10.00, '2026-03-04', 'Active', 10),
    (11, 10.00, '2026-03-05', 'Active', 11),
    (12, 10.00, '2026-03-06', 'Active', 12),
    (13, 10.00, '2026-03-07', 'Active', 13);


-- ── Extra Fees ────────────────────────────────────────────────
INSERT INTO ExtraFee (FeeType, Amount)
VALUES
    ('Extra Class Fee',      5.00),
    ('Weekly Subscription', 10.00);


-- ── Member Fees ───────────────────────────────────────────────
INSERT INTO MemberFee (MemberId, FeeId, DateCharged, MemberMemberId, ExtraFeeFeeId)
VALUES
    (1,  1, '2026-03-10', 1,  1),   -- Anisha  – extra class charge
    (2,  2, '2026-03-10', 2,  2),   -- Alina   – weekly subscription
    (3,  1, '2026-03-10', 3,  1),   -- Soniya  – extra class charge
    (4,  2, '2026-03-10', 4,  2),   -- Arpit   – weekly subscription
    (5,  1, '2026-03-10', 5,  1),   -- Riwaj   – extra class charge
    (6,  2, '2026-03-10', 6,  2),   -- Pratik  – weekly subscription
    (7,  1, '2026-03-10', 7,  1),   -- Luna    – extra class charge
    (8,  2, '2026-03-10', 8,  2),   -- Drishti – weekly subscription
    (9,  1, '2026-03-10', 9,  1),   -- Sanjog  – extra class charge
    (10, 2, '2026-03-10', 10, 2),   -- Bibek   – weekly subscription
    (11, 1, '2026-03-10', 11, 1),   -- Kriti   – extra class charge
    (12, 2, '2026-03-10', 12, 2),   -- Roshan  – weekly subscription
    (13, 1, '2026-03-10', 13, 1);   -- Nischal – extra class charge


-- ============================================================
-- SELECT QUERIES TO VERIFY ALL DATA
-- ============================================================
SELECT * FROM Member;
SELECT * FROM Staff;
SELECT * FROM Class;
SELECT * FROM ClassSchedule;
SELECT * FROM Facility;
SELECT * FROM ClassBooking;
SELECT * FROM FacilityBooking;
SELECT * FROM Membership;
SELECT * FROM ExtraFee;
SELECT * FROM MemberFee;