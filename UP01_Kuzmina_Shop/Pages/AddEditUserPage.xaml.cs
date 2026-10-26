using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Security.Cryptography;
using System.Text;
using UP01_Kuzmina_Shop; // Подключаем корень проекта для SHOPIEntities

namespace UP01_Kuzmina_Shop.Pages
{
    public partial class AddEditUserPage : Page
    {
        private Users _currentUser;

        public AddEditUserPage(Users selectedUser)
        {
            InitializeComponent();

            if (selectedUser != null)
            {
                _currentUser = selectedUser;
                TbTitle.Text = "Редактирование пользователя";
            }
            else
            {
                _currentUser = new Users();
            }

            DataContext = _currentUser;

            if (_currentUser.Role != null)
            {
                foreach (ComboBoxItem item in CbRole.Items)
                {
                    if (item.Content.ToString() == _currentUser.Role)
                    {
                        CbRole.SelectedItem = item;
                        break;
                    }
                }
            }
        }

        public static string GetHash(string password)
        {
            using (var hash = SHA1.Create())
            {
                return string.Concat(hash.ComputeHash(Encoding.UTF8.GetBytes(password)).Select(x => x.ToString("X2")));
            }
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TbLogin.Text) || string.IsNullOrWhiteSpace(TbFIO.Text))
            {
                MessageBox.Show("Заполните логин и ФИО!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            using (var db = new SHOPINGEntities())
            {
                if (_currentUser.ID == 0)
                {
                    var userExists = db.Users.Any(u => u.Login == TbLogin.Text);
                    if (userExists)
                    {
                        MessageBox.Show("Пользователь с таким логином уже существует!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }
                    _currentUser.Login = TbLogin.Text;
                }

                _currentUser.FIO = TbFIO.Text;
                _currentUser.Role = (CbRole.SelectedItem as ComboBoxItem).Content.ToString();

                if (!string.IsNullOrWhiteSpace(PbPassword.Password))
                {
                    _currentUser.Password = GetHash(PbPassword.Password);
                }

                if (_currentUser.ID == 0)
                {
                    db.Users.Add(_currentUser);
                }
                else
                {
                    db.Entry(_currentUser).State = System.Data.Entity.EntityState.Modified;
                }

                try
                {
                    db.SaveChanges();
                    MessageBox.Show("Данные сохранены!", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
                    NavigationService?.Navigate(new UsersTabPage());
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка при сохранении: " + ex.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new UsersTabPage());
        }
    }
}