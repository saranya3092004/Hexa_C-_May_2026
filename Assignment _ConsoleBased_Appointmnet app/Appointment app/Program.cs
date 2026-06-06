using System;
using System.Collections.Generic;

namespace Appointment_app
{
    public  class Program
    {
        static void Main(string[] args)
        {
            List<Appointment> appointments = new List<Appointment>();

            Appointment a1 = new Appointment
            {
                AppointmentId = 1,
                PatientName = "Arun",
                DoctorName = "Dr. Meena",
                PatientAge = 25,
                AppointmentDate = DateTime.Now.AddDays(2),
                Specialization = "Cardiology",
                ConsultationFee = 500
            };

            Appointment a2 = new Appointment
            {
                AppointmentId = 2,
                PatientName = "Kavya",
                DoctorName = "Dr. Raj",
                PatientAge = 30,
                AppointmentDate = DateTime.Now.AddDays(1),
                Specialization = "Dermatology",
                ConsultationFee = 300
            };

            appointments.Add(a1);
            appointments.Add(a2);

            foreach (var appt in appointments)
            {
                appt.ScheduleAppointment();
            }

            foreach (var appt in appointments)
            {
                appt.Display();
            }

            Console.WriteLine("\n--- Cardiology Appointments ---");
            foreach (var appt in appointments)
            {
                if (appt.Specialization == "Cardiology")
                {
                    appt.Display();
                }
            }

            Console.WriteLine("\n--- Dermatology Appointments ---");
            foreach (var appt in appointments)
            {
                if (appt.Specialization == "Dermatology")
                {
                    appt.Display();
                }
            }

        }
    }
}