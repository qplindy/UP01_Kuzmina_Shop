using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Data.Entity; // ЭТА СТРОЧКА ИСПРАВЛЯЕТ ОШИБКУ SaveChanges

namespace UP01_Kuzmina_Shop.Pages
{
    public partial class AuthPage : Page
    {
        private int failedAttempts = 0;

        public AuthPage()
        {
            InitializeComponent();
            if (failedAttempts >= 3)
            {
                GenerateCaptcha();
            }
        }

        public static string GetHash(string password)
        {
            using (var hash = SHA1.Create())
            {
                return string.Concat(hash.ComputeHash(Encoding.UTF8.GetBytes(password)).Select(x => x.ToString("X2")));
            }
        }

        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(TextBoxLogin.Text) || string.IsNullOrEmpty(PasswordBoxPass.Password))
            {
                MessageBox.Show("Введите логин и пароль!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (CaptchaPanel.Visibility == Visibility.Visible)
            {
                if (TextBoxCaptcha.Text != CaptchaText.Text)
                {
                    MessageBox.Show("Неверно введена капча!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    GenerateCaptcha();
                    return;
                }
            }

            string hashedPassword = GetHash(PasswordBoxPass.Password);

            using (var db = new SHOPEntities()) // Используем наше имя класса
            {
                var user = db.Users.AsNoTracking().FirstOrDefault(u => u.Login == TextBoxLogin.Text && u.Password == hashedPassword);

                if (user == null)
                {
                    failedAttempts++;
                    MessageBox.Show($"Неверный логин или пароль! Попытка {failedAttempts} из 3.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);

                    if (failedAttempts >= 3)
                    {
                        CaptchaPanel.Visibility = Visibility.Visible;
                        GenerateCaptcha();
                    }
                    return;
                }

                MessageBox.Show($"Добро пожаловать, {user.FIO}!", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);

                Core.CurrentUser = user;

                if (user.Role == "Администратор")
                {
                    MessageBox.Show("Вы вошли как Администратор!");
                }
                else
                {
                    MessageBox.Show("Вы вошли как Пользователь!");
                }
            }
        }

        private void BtnRegister_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new RegPage());
        }

        private void GenerateCaptcha()
        {
            string allowChar = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,y,z,1,2,3,4,5,6,7,8,9,0";
            string[] ar = allowChar.Split(',');
            string pwd = "";
            Random r = new Random();

            for (int i = 0; i < 6; i++)
            {
                pwd += ar[r.Next(0, ar.Length)];
            }

            CaptchaText.Text = pwd;
            TextBoxCaptcha.Text = "";
            CaptchaPanel.Visibility = Visibility.Visible;
        }
    }
}