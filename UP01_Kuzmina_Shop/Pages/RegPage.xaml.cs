using System;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Security.Cryptography;
using UP01_Kuzmina_Shop;

namespace UP01_Kuzmina_Shop.Pages
{
    public partial class RegPage : Page
    {
        public RegPage()
        {
            InitializeComponent();

            var cmb = Core.Context.roles.ToList();
            CbRole.ItemsSource = cmb;
        }

        public static string GetHash(string password)
        {
            using (var hash = SHA1.Create())
            {
                return string.Concat(hash.ComputeHash(Encoding.UTF8.GetBytes(password)).Select(x => x.ToString("X2")));
            }
        }

        private void BtnRegister_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TbLogin.Text) || string.IsNullOrWhiteSpace(PbPassword.Password) ||
                string.IsNullOrWhiteSpace(PbConfirmPassword.Password) || string.IsNullOrWhiteSpace(TbFIO.Text))
            {
                MessageBox.Show("Заполните все поля!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (PbPassword.Password.Length < 6)
            {
                MessageBox.Show("Пароль должен содержать минимум 6 символов!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            bool hasDigit = false;
            bool isEnglish = true;

            foreach (char c in PbPassword.Password)
            {
                if (c >= '0' && c <= '9') hasDigit = true;
                else if (!((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z'))) isEnglish = false;
            }

            if (!isEnglish)
            {
                MessageBox.Show("Используйте только английскую раскладку в пароле!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (!hasDigit)
            {
                MessageBox.Show("Пароль должен содержать хотя бы одну цифру!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (PbPassword.Password != PbConfirmPassword.Password)
            {
                MessageBox.Show("Пароли не совпадают!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            // ПРОВЕРКА НА ВЫБОР РОЛИ (защита от ошибки NullReferenceException)
            string selectedRole = "Пользователь";
            if (CbRole.SelectedItem != null)
            {
                var comboBoxItem = CbRole.SelectedItem as ComboBoxItem;
                if (comboBoxItem != null)
                {
                    selectedRole = comboBoxItem.Content.ToString();
                }
            }

            using (var db = new SHOPINGEntities())
            {
                var userExists = db.Users.Any(u => u.Login == TbLogin.Text);
                if (userExists)
                {
                    MessageBox.Show("Пользователь с таким логином уже существует!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                Users newUser = new Users
                {
                    Login = TbLogin.Text,
                    Password = GetHash(PbPassword.Password),
                    FIO = TbFIO.Text,
                    Role = selectedRole // Используем проверенную роль
                };

                db.Users.Add(newUser);
                db.SaveChanges();
            }

            MessageBox.Show("Регистрация прошла успешно! Теперь вы можете войти.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            NavigationService?.Navigate(new AuthPage());
        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new AuthPage());
        }
    }
}