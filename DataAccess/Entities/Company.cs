using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess.Entities;

public class Company
{
    public int EC { get; set; }

    public DateTime F { get; set; }

    [MaxLength(255)]
    public string HQ { get; set; }

    [MaxLength(255)]
    public string CEO { get; set; }

    [MaxLength(255)]
    public string EH { get; set; }

    [MaxLength(255)]
    public string SYM { get; set; }

    [MaxLength(255)]
    public string Name { get; set; }

    [Key]
    public int Id { get; set; }

    [MaxLength(255)]
    public string Industry { get; set; }

    [Column(TypeName = "nvarchar(MAX)")]
    public string Description { get; set; }
}