using System;
using System.Collections.Generic;
using System.Text;

namespace Appointment_app
{
    public partial class Appointment
    {
        public bool Validation()
        {
            if (string.IsNullOrEmpty(AppointmentData.PatientName) || string.IsNullOrEmpty(AppointmentData.DoctorName) || string.IsNullOrEmpty(AppointmentData.Specialization))
            {
                Console.WriteLine("Patient Name, Doctor Name and Specialization cannot be empty.");
                return false;
            }
            return true;
        }
    }
}
