using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using UP01_Kuzmina_Shop;

namespace UP01_Kuzmina_Shop.Pages
{
    public partial class AuthPage : Page
    {
        private int failedAttempts = 0; // Счетчик неверных попыток

        public AuthPage()
        {
            InitializeComponent();
            if (failedAttempts >= 3)
            {
                GenerateCaptcha();
            }
        }

        // Метод для хэширования пароля
        public static string GetHash(string password)
        {
            using (var hash = SHA1.Create())
            {
                return string.Concat(hash.ComputeHash(Encoding.UTF8.GetBytes(password)).Select(x => x.ToString("X2")));
            }
        }

        // Кнопка "Войти"
        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            // 1. Проверка на пустые поля
            if (string.IsNullOrEmpty(TextBoxLogin.Text) || string.IsNullOrEmpty(PasswordBoxPass.Password))
            {
                MessageBox.Show("Введите логин и пароль!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            // 2. Проверка капчи
            if (CaptchaPanel.Visibility == Visibility.Visible)
            {
                if (TextBoxCaptcha.Text != CaptchaText.Text)
                {
                    MessageBox.Show("Неверно введена капча!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    GenerateCaptcha(); // Обновляем капчу
                    return;
                }
            }

            // 3. Хэшируем введенный пароль и ищем пользователя в БД
            string hashedPassword = GetHash(PasswordBoxPass.Password);

            using (var db = new SHOPINGEntities()) // Твоя модель базы данных
            {
                var user = db.Users.AsNoTracking().FirstOrDefault(u => u.Login == TextBoxLogin.Text && u.Password == hashedPassword);

                if (user == null)
                {
                    failedAttempts++;
                    MessageBox.Show($"Неверный логин или пароль! Попытка {failedAttempts} из 3.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);

                    // Если 3 и более попыток, включаем капчу
                    if (failedAttempts >= 3)
                    {
                        CaptchaPanel.Visibility = Visibility.Visible;
                        GenerateCaptcha();
                    }
                    return;
                }

                // 4. Если пользователь найден - переходим на нужную страницу
                MessageBox.Show($"Добро пожаловать, {user.FIO}!", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);

                // Запоминаем текущего пользователя
                Core.CurrentUser = user;

                // Проверяем роль и перенаправляем
                if (user.Role == "Администратор")
                {
                    MessageBox.Show("Вы вошли как Администратор!");
                    NavigationService?.Navigate(new AdminPage());
                }
                else
                {
                    MessageBox.Show("Вы вошли как Пользователь!");
                    NavigationService?.Navigate(new UserPage()); // <--- ВОТ ЗДЕСЬ РАСКОММЕНТИРОВАНО
                }
            }
        }

        // Кнопка "Регистрация"
        private void BtnRegister_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new RegPage());
        }

        // Метод генерации случайной капчи
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
            TextBoxCaptcha.Text = ""; // Очищаем поле ввода
            CaptchaPanel.Visibility = Visibility.Visible;
        }
    }
}