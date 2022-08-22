# TestTaskHaulmont

# Реализовано
- Метаинформация и обложки загружаются через внешний сервис (http://www.themoviedb.org)
- Главный экран со списком фильмов(CollectionView)
- Экран деталей фильма(UIView with VisualEffectView)
- Экран деталей фильма в поисковом экране (ViewController)
- Асинхронная загрузка метаданных и постеров (GCD)
- Профиль разработчика (side menu)
- Возможность искать фильмы по имени во внешнем сервисе
- Список фильмов хранится локально на устройстве
- Поиск работает по имени фильма
- Результаты поиска отображаются в таблице (TableView)
- Фильм из найденного списка можно добавить в свою коллекцию фильмов
- Своя коллекция фильмов реализована через (CollectionView + CoreData)
- Возможность добавлять в свою коллекцию фильмы как с главного экрана, так и с экрана поиска фильмов
- Возможность удалять фильмы из коллекции
---
- Формат выдачи данных JSON
- Приложение  поддерживает iOS 13 и выше
- Приложение работает с использованием Autolayout
- Приложение написано без использования Storyboard(полностью кодом)
- При выполнении работы не использовались сторонние библиотеки
- Гибко настроенная структура приложения 
---
# Визуальная часть
## Главный экран
<img src="/Search1.png" alt="Search1"/> <img src="/Search1.png" alt="Search1"/> <img src="/Search1.png" alt="Search1"/>


---
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-15 at 20 01 28](https://user-images.githubusercontent.com/100344157/185918501-fdec9972-2f5a-426c-b4c6-dcdc95fc7a21.png) 
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-15 at 20 01 46](https://user-images.githubusercontent.com/100344157/185918527-63ce2ffb-1317-4a95-a6d1-6319064de376.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-22 at 16 16 50](https://user-images.githubusercontent.com/100344157/185919718-b7a42a33-fb70-410d-b1fb-a03a56630f09.png)

## Экран поиска фильмов
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-22 at 17 30 46](https://user-images.githubusercontent.com/100344157/185933299-86ece3cb-4f06-496c-bd67-ee3e043e3dc8.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-15 at 20 02 42](https://user-images.githubusercontent.com/100344157/185918629-9dc6e4c3-76e8-49b2-89b6-c0ad12a64901.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-22 at 17 32 35](https://user-images.githubusercontent.com/100344157/185933566-05a3a4f9-30c7-440a-a628-9e26febf57c1.png)


## Экран собственной коллекции фильмов
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-22 at 16 18 17](https://user-images.githubusercontent.com/100344157/185919677-eaf75a87-a525-413a-bc3f-44098314b926.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-22 at 16 18 31](https://user-images.githubusercontent.com/100344157/185919693-76b6f810-bfc1-410c-aff3-5eb35c413f4e.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-22 at 16 18 49](https://user-images.githubusercontent.com/100344157/185919701-4a5c0b37-dd09-488e-9d3f-738f2bd20fff.png)

## Экран разработчика
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-15 at 20 01 59](https://user-images.githubusercontent.com/100344157/185918668-4540baaa-3a8a-4fb3-bde3-21ce43184428.png)
