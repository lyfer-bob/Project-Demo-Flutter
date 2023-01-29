# Hotel Management System

Self Check-in & Check-out Function

## Scenario

เมื่อแขกเดินทางมาถึงที่พัก จะต้องแจ้งเลขห้อง ชื่อและอายุ เพื่อทำ Check-in เข้าพัก จากนั้นระบบจะออก Keycard ให้แขกเพื่อใช้ในการเปิดประตูห้องพัก

และเมื่อแขกต้องการ Check-out จะต้องนำ Keycard มาคืนพร้อมแจ้งชื่อ ให้ตรงกับที่ระบุไว้ใน Keycard ตอน Check-in ถึงจะสามารถ Check-out ได้

โดยพนักงานจะต้องสามารถ

1. สร้างโรงแรมโดยกำหนดจำนวนชั้นและจำนวนห้องต่อชั้นได้
   เลขห้องจะต้องเป็นเลข 3 หลัก ตัวแรกคือเลขชั้น 2 ตัวที่เหลือคือเลขห้อง เริ่มจาก 01
2. ดูรายการห้องว่างทั้งหมดได้
3. ดูรายชื่อแขกทั้งหมดได้
4. ดูรายชื่อแขกโดยกำหนดช่วงอายุได้
5. ดูชื่อแขกในห้องพักที่ระบุได้

```bash
$ node main.js
Hotel created with 2 floor(s), 3 room(s) per floor.
Room 203 is booked by Thor with keycard number 1.
Room 101 is booked by PeterParker with keycard number 2.
Room 102 is booked by StephenStrange with keycard number 3.
Room 201 is booked by TonyStark with keycard number 4.
Room 202 is booked by TonyStark with keycard number 5.
Cannot book room 203 for TonyStark, The room is currently booked by Thor.
103
Room 201 is checkout.
Room 103 is booked by TonyStark with keycard number 4.
Hotel is fully booked.
Only Thor can checkout with keycard number 1.
Room 202 is checkout.
Room 103 is checkout.
Thor, PeterParker, StephenStrange
Thor
PeterParker
```

## วิธีการทำโจทย์

1. เลือกภาษาที่ใช้เขียนโค้ด
2. แปลงโค้ดในไฟล์ main.js เป็นภาษาที่เลือก
3. ทดสอบการทำงานของโปรแกรมโดยใช้ข้อมูลนำเข้าจากไฟล์  input.txt และต้องได้ผลลัพธ์เหมือนไฟล์ ouput.txt

\*\*\* มีเวลาทำ 48 ชั่วโมง เริ่มนับเวลาจากที่ได้รับโจทย์ผ่านทาง Email

## สิ่งที่คาดหวัง

- Code Style
- Programming Language Proficiency
- OOP/Functional Programming
