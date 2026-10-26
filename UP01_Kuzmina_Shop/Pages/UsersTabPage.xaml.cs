using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using UP01_Kuzmina_Shop; 

namespace UP01_Kuzmina_Shop.Pages
{
    public partial class UsersTabPage : Page
    {
        public UsersTabPage()
        {
            InitializeComponent();
            LoadData();
        }

        // Метод для загрузки данных в таблицу
        private void LoadData()
        {
            using (var db = new SHOPINGEntities()) 
            {
                // Получаем всех пользователей из БД
                List<Users> users = db.Users.ToList();

                // Фильтрация по поиску (ФИО)
                if (!string.IsNullOrWhiteSpace(TbSearch.Text))
                {
                    string search = TbSearch.Text.ToLower();
                    users = users.Where(u => u.FIO.ToLower().Contains(search)).ToList();
                }

                // Фильтрация "Только администраторы"
                if (CbAdminsOnly.IsChecked == true)
                {
                    users = users.Where(u => u.Role == "Администратор").ToList();
                }

                // Сортировка
                if (CbSort.SelectedIndex == 0)
                    users = users.OrderBy(u => u.FIO).ToList();
                else
                    users = users.OrderByDescending(u => u.FIO).ToList();

                // Привязываем к таблице
                DataGridUsers.ItemsSource = users;
            }
        }

        // Обработчики событий для поиска и фильтрации
        private void TbSearch_TextChanged(object sender, TextChangedEventArgs e) { LoadData(); }
        private void CbSort_SelectionChanged(object sender, SelectionChangedEventArgs e) { LoadData(); }
        private void CbAdminsOnly_Changed(object sender, RoutedEventArgs e) { LoadData(); }

        // Кнопка "Назад"
        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new AdminPage());
        }

        // Кнопка "Добавить"
        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Форма добавления в разработке", "Внимание");
        }

        // Кнопка "Удалить"
        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            var selectedUser = DataGridUsers.SelectedItem as Users;
            if (selectedUser == null)
            {
                MessageBox.Show("Выберите пользователя для удаления!", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            MessageBoxResult result = MessageBox.Show($"Вы уверены, что хотите удалить пользователя {selectedUser.FIO}?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                using (var db = new SHOPINGEntities())
                {
                    var userToDelete = db.Users.FirstOrDefault(u => u.ID == selectedUser.ID);
                    if (userToDelete != null)
                    {
                        db.Users.Remove(userToDelete);
                        db.SaveChanges();
                    }
                }
                LoadData(); // Обновляем таблицу
                MessageBox.Show("Пользователь удален!", "Успех");
            }
        }
    }
}